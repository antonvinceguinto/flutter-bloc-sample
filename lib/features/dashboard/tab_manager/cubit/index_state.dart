part of 'index_cubit.dart';

class IndexState extends Equatable {
  const IndexState(this.currentIndex);

  final int currentIndex;

  IndexState copyWith({
    int? currentIndex,
  }) =>
      IndexState(
        currentIndex ?? this.currentIndex,
      );

  @override
  List<Object> get props => [currentIndex];
}
