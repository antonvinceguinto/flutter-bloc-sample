part of 'crypto_ticker_cubit.dart';

@immutable
class CryptoTickerState extends Equatable {
  const CryptoTickerState();

  @override
  List<Object> get props => [];
}

class CryptoTickerLoading extends CryptoTickerState {}

class CryptoTickerLoaded extends CryptoTickerState {
  const CryptoTickerLoaded({
    required this.trendingCoins,
  });

  final List<TokenData> trendingCoins;

  @override
  List<Object> get props => [trendingCoins];
}

class CryptoTickerError extends CryptoTickerState {
  const CryptoTickerError({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
