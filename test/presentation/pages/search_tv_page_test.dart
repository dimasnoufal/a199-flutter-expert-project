import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_bloc.dart';
import 'package:ditonton/presentation/pages/search_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTvSearchBloc extends MockBloc<TvSearchEvent, TvSearchState>
    implements TvSearchBloc {}

void main() {
  late MockTvSearchBloc mockBloc;

  setUp(() {
    mockBloc = MockTvSearchBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSearchBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display progress bar when loading', (
    WidgetTester tester,
  ) async {
    when(() => mockBloc.state).thenReturn(TvSearchLoading());

    await tester.pumpWidget(makeTestableWidget(SearchTvPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (
    WidgetTester tester,
  ) async {
    when(() => mockBloc.state).thenReturn(const TvSearchLoaded(<Tv>[]));

    await tester.pumpWidget(makeTestableWidget(SearchTvPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display empty container when state is empty', (
    WidgetTester tester,
  ) async {
    when(() => mockBloc.state).thenReturn(TvSearchEmpty());

    await tester.pumpWidget(makeTestableWidget(SearchTvPage()));

    expect(find.byType(Container), findsWidgets);
  });
}
