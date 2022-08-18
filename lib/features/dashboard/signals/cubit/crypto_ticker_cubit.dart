import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coingecko_repository/coingecko_repository.dart';
import 'package:coingecko_repository/models/token_data.dart';
import 'package:equatable/equatable.dart';

part 'crypto_ticker_state.dart';

class CryptoTickerCubit extends Cubit<CryptoTickerState> {
  CryptoTickerCubit({required CoinGeckoRepositoryImpl coinGeckoRepositoryImpl})
      : _coinGeckoRepositoryImpl = coinGeckoRepositoryImpl,
        super(CryptoTickerLoading()) {
    unawaited(loadTicker());
  }

  final CoinGeckoRepositoryImpl _coinGeckoRepositoryImpl;

  Future<void> loadTicker() async {
    emit(CryptoTickerLoading());
    try {
      final res = await _coinGeckoRepositoryImpl.getTokenDataList([
        'bitcoin',
        'ethereum',
        'ripple',
        'binancecoin',
        'cardano',
        'solana',
        'polkadot',
        'dogecoin',
      ]);
      emit(CryptoTickerLoaded(trendingCoins: res));
    } catch (e) {
      emit(CryptoTickerError(errorMessage: e.toString()));
    }
  }
}
