import 'package:bloc_vgv_todoapp/features/dashboard/signals/cubit/crypto_ticker_cubit.dart';
import 'package:coingecko_repository/coingecko_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CryptoTicker extends StatelessWidget {
  const CryptoTicker({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => CoinGeckoRepositoryImpl(),
      child: BlocProvider(
        create: (context) => CryptoTickerCubit(
          coinGeckoRepositoryImpl: context.read<CoinGeckoRepositoryImpl>(),
        ),
        child: const CryptoTickerView(),
      ),
    );
  }
}

class CryptoTickerView extends StatelessWidget {
  const CryptoTickerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoTickerCubit, CryptoTickerState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return SizedBox(
          height: 210,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price Updates',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(
                      onPressed: () =>
                          context.read<CryptoTickerCubit>().loadTicker(),
                      icon: const Icon(Icons.refresh),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: state is CryptoTickerLoading
                      ? _itemShimmer()
                      : state is CryptoTickerError
                          ? Text(
                              state.errorMessage,
                              textAlign: TextAlign.center,
                            )
                          : _tickerList(context),
                ),
              ),
              const SizedBox(height: 4),
              const Divider(
                color: Colors.green,
                height: 1,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _itemShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.white.withOpacity(0.2),
      highlightColor: Colors.white.withOpacity(0.5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            4,
            (index) => Container(
              height: double.infinity,
              width: 100,
              margin: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 10,
              ),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tickerList(BuildContext context) {
    final trendingCoins =
        (context.read<CryptoTickerCubit>().state as CryptoTickerLoaded)
            .trendingCoins;

    if (trendingCoins == null || trendingCoins[0].name == null) {
      return const Text("Can't load ticker. Try again later.");
    }

    return ListView.builder(
      itemCount: trendingCoins.length,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 4,
      ),
      itemBuilder: (context, index) {
        final coin = trendingCoins[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.green,
            ),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 4,
          ),
          padding: const EdgeInsets.all(8),
          height: double.infinity,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${coin.symbol?.toUpperCase()}',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  '${coin.image?.large}',
                  height: 40,
                  width: 40,
                ),
              ),
              Text('\$${coin.marketData?.currentPrice?.usd}'),
            ],
          ),
        );
      },
    );
  }
}
