part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvDetail extends TvDetailEvent {
  final int id;

  const FetchTvDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvToWatchlist extends TvDetailEvent {
  final TvDetail tv;

  const AddTvToWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveTvFromWatchlist extends TvDetailEvent {
  final TvDetail tv;

  const RemoveTvFromWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadTvWatchlistStatus extends TvDetailEvent {
  final int id;

  const LoadTvWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
