import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:ditonton/presentation/pages/home_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTvListBloc extends MockBloc<TvListEvent, TvListState>
    implements TvListBloc {}

void main() {
  late MockTvListBloc mockBloc;

  setUp(() {
    mockBloc = MockTvListBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvListBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading', (
    WidgetTester tester,
  ) async {
    when(() => mockBloc.state).thenReturn(
      const TvListState(
        onTheAirState: RequestState.Loading,
        popularTvState: RequestState.Loading,
        topRatedTvState: RequestState.Loading,
      ),
    );

    await tester.pumpWidget(makeTestableWidget(HomeTvPage()));

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('Page should display ListView when data is loaded', (
    WidgetTester tester,
  ) async {
    when(() => mockBloc.state).thenReturn(
      TvListState(
        onTheAirState: RequestState.Loaded,
        onTheAirTv: <Tv>[],
        popularTvState: RequestState.Loaded,
        popularTv: <Tv>[],
        topRatedTvState: RequestState.Loaded,
        topRatedTv: <Tv>[],
      ),
    );

    await tester.pumpWidget(makeTestableWidget(HomeTvPage()));

    expect(find.byType(ListView), findsWidgets);
  });

  testWidgets('Page should display text with message when Error', (
    WidgetTester tester,
  ) async {
    when(() => mockBloc.state).thenReturn(
      const TvListState(
        onTheAirState: RequestState.Error,
        popularTvState: RequestState.Error,
        topRatedTvState: RequestState.Error,
        message: 'Error message',
      ),
    );

    await tester.pumpWidget(makeTestableWidget(HomeTvPage()));

    expect(find.text('Failed'), findsWidgets);
  });
}
