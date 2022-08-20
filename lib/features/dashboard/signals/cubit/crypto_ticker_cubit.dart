import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coingecko_repository/coingecko_repository.dart';
import 'package:coingecko_repository/models/token_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'crypto_ticker_state.dart';

class CryptoTickerCubit extends Cubit<CryptoTickerState> {
  CryptoTickerCubit({required CoinGeckoRepositoryImpl coinGeckoRepositoryImpl})
      : _coinGeckoRepositoryImpl = coinGeckoRepositoryImpl,
        super(const CryptoTickerState()) {
    unawaited(loadTicker());
  }

  final CoinGeckoRepositoryImpl _coinGeckoRepositoryImpl;

  Future<void> loadTicker() async {
    try {
      if (state is CryptoTickerLoading) return;
      emit(CryptoTickerLoading());
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
      if (res != null) {
        emit(CryptoTickerLoaded(trendingCoins: res));
      } else {
        emit(const CryptoTickerError(errorMessage: "Can't load Token Ticker"));
      }
    } catch (e) {
      emit(const CryptoTickerError(errorMessage: "Can't load Token Ticker"));
    }
  }
}
