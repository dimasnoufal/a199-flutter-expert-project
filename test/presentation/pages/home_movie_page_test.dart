import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieListBloc extends MockBloc<MovieListEvent, MovieListState>
    implements MovieListBloc {}

void main() {
  late MockMovieListBloc mockBloc;

  setUp(() {
    mockBloc = MockMovieListBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieListBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading', (
    WidgetTester tester,
  ) async {
    when(() => mockBloc.state).thenReturn(
      const MovieListState(
        nowPlayingState: RequestState.Loading,
        popularMoviesState: RequestState.Loading,
        topRatedMoviesState: RequestState.Loading,
      ),
    );

    await tester.pumpWidget(makeTestableWidget(HomeMoviePage()));

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('Page should display ListView when data is loaded', (
    WidgetTester tester,
  ) async {
    when(() => mockBloc.state).thenReturn(
      MovieListState(
        nowPlayingState: RequestState.Loaded,
        nowPlayingMovies: <Movie>[],
        popularMoviesState: RequestState.Loaded,
        popularMovies: <Movie>[],
        topRatedMoviesState: RequestState.Loaded,
        topRatedMovies: <Movie>[],
      ),
    );

    await tester.pumpWidget(makeTestableWidget(HomeMoviePage()));

    expect(find.byType(ListView), findsWidgets);
  });

  testWidgets('Page should display text with message when Error', (
    WidgetTester tester,
  ) async {
    when(() => mockBloc.state).thenReturn(
      const MovieListState(
        nowPlayingState: RequestState.Error,
        popularMoviesState: RequestState.Error,
        topRatedMoviesState: RequestState.Error,
        message: 'Error message',
      ),
    );

    await tester.pumpWidget(makeTestableWidget(HomeMoviePage()));

    expect(find.text('Failed'), findsWidgets);
  });
}
