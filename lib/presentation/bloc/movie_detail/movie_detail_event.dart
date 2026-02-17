part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetail extends MovieDetailEvent {
  final int id;

  const FetchMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddMovieWatchlist extends MovieDetailEvent {
  final MovieDetail movie;

  const AddMovieWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveMovieWatchlist extends MovieDetailEvent {
  final MovieDetail movie;

  const RemoveMovieWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadMovieWatchlistStatus extends MovieDetailEvent {
  final int id;

  const LoadMovieWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
