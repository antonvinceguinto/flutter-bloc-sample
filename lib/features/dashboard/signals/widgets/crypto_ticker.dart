import 'package:bloc_vgv_todoapp/features/dashboard/signals/cubit/crypto_ticker_cubit.dart';
import 'package:coingecko_repository/coingecko_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CryptoTicker extends StatelessWidget {
  const CryptoTicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CryptoTickerCubit(
        coinGeckoRepositoryImpl: context.read<CoinGeckoRepositoryImpl>(),
      ),
      child: const CryptoTickerView(),
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
          height: 140,
          child: Column(
            children: [
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
              const Divider(
                color: Colors.amber,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${coin.symbol?.toUpperCase()}',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  '${coin.image?.large}',
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(height: 8),
              Text('\$${coin.marketData?.currentPrice?.usd}'),
            ],
          ),
        );
      },
    );
  }
}
