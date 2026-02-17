import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc({required this.searchMovies}) : super(MovieSearchEmpty()) {
    on<OnQueryChanged>(_onQueryChanged);
  }

  Future<void> _onQueryChanged(
    OnQueryChanged event,
    Emitter<MovieSearchState> emit,
  ) async {
    emit(MovieSearchLoading());
    final result = await searchMovies.execute(event.query);
    result.fold(
      (failure) => emit(MovieSearchError(failure.message)),
      (data) => emit(MovieSearchLoaded(data)),
    );
  }
}
