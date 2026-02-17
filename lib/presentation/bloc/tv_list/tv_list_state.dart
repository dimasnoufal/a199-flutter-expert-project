part of 'tv_list_bloc.dart';

class TvListState extends Equatable {
  final List<Tv> onTheAirTv;
  final RequestState onTheAirState;
  final List<Tv> popularTv;
  final RequestState popularTvState;
  final List<Tv> topRatedTv;
  final RequestState topRatedTvState;
  final String message;

  const TvListState({
    this.onTheAirTv = const [],
    this.onTheAirState = RequestState.Empty,
    this.popularTv = const [],
    this.popularTvState = RequestState.Empty,
    this.topRatedTv = const [],
    this.topRatedTvState = RequestState.Empty,
    this.message = '',
  });

  TvListState copyWith({
    List<Tv>? onTheAirTv,
    RequestState? onTheAirState,
    List<Tv>? popularTv,
    RequestState? popularTvState,
    List<Tv>? topRatedTv,
    RequestState? topRatedTvState,
    String? message,
  }) {
    return TvListState(
      onTheAirTv: onTheAirTv ?? this.onTheAirTv,
      onTheAirState: onTheAirState ?? this.onTheAirState,
      popularTv: popularTv ?? this.popularTv,
      popularTvState: popularTvState ?? this.popularTvState,
      topRatedTv: topRatedTv ?? this.topRatedTv,
      topRatedTvState: topRatedTvState ?? this.topRatedTvState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
    onTheAirTv,
    onTheAirState,
    popularTv,
    popularTvState,
    topRatedTv,
    topRatedTvState,
    message,
  ];
}
