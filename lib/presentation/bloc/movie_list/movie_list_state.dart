part of 'movie_list_bloc.dart';

class MovieListState extends Equatable {
  final List<Movie> nowPlayingMovies;
  final RequestState nowPlayingState;
  final List<Movie> popularMovies;
  final RequestState popularMoviesState;
  final List<Movie> topRatedMovies;
  final RequestState topRatedMoviesState;
  final String message;

  const MovieListState({
    this.nowPlayingMovies = const [],
    this.nowPlayingState = RequestState.Empty,
    this.popularMovies = const [],
    this.popularMoviesState = RequestState.Empty,
    this.topRatedMovies = const [],
    this.topRatedMoviesState = RequestState.Empty,
    this.message = '',
  });

  MovieListState copyWith({
    List<Movie>? nowPlayingMovies,
    RequestState? nowPlayingState,
    List<Movie>? popularMovies,
    RequestState? popularMoviesState,
    List<Movie>? topRatedMovies,
    RequestState? topRatedMoviesState,
    String? message,
  }) {
    return MovieListState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularMovies: popularMovies ?? this.popularMovies,
      popularMoviesState: popularMoviesState ?? this.popularMoviesState,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      topRatedMoviesState: topRatedMoviesState ?? this.topRatedMoviesState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
    nowPlayingMovies,
    nowPlayingState,
    popularMovies,
    popularMoviesState,
    topRatedMovies,
    topRatedMoviesState,
    message,
  ];
}
