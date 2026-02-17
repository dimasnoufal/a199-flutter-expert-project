import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistTvBloc extends MockBloc<WatchlistTvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}

void main() {
  late MockWatchlistTvBloc mockBloc;

  setUp(() {
    mockBloc = MockWatchlistTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body, navigatorObservers: [routeObserver]),
    );
  }

  testWidgets('Page should display center progress bar when loading', (
    WidgetTester tester,
  ) async {
    when(() => mockBloc.state).thenReturn(WatchlistTvLoading());

    await tester.pumpWidget(makeTestableWidget(WatchlistTvPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (
    WidgetTester tester,
  ) async {
    when(() => mockBloc.state).thenReturn(const WatchlistTvLoaded(<Tv>[]));

    await tester.pumpWidget(makeTestableWidget(WatchlistTvPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (
    WidgetTester tester,
  ) async {
    when(
      () => mockBloc.state,
    ).thenReturn(const WatchlistTvError('Error message'));

    await tester.pumpWidget(makeTestableWidget(WatchlistTvPage()));

    expect(find.byKey(const Key('error_message')), findsOneWidget);
  });
}
