import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/home_tv_page.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_tv_page_test.mocks.dart';

@GenerateMocks([TvListNotifier])
void main() {
  late MockTvListNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvListNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvListNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Page should display center progress bar when loading on the air tv',
      (WidgetTester tester) async {
    when(mockNotifier.onTheAirState).thenReturn(RequestState.Loading);
    when(mockNotifier.popularTvState).thenReturn(RequestState.Loading);
    when(mockNotifier.topRatedTvState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display TvList when on the air data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.onTheAirState).thenReturn(RequestState.Loaded);
    when(mockNotifier.onTheAirTv).thenReturn(testTvList);
    when(mockNotifier.popularTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularTv).thenReturn(testTvList);
    when(mockNotifier.topRatedTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedTv).thenReturn(testTvList);

    await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

    expect(find.byType(ListView), findsWidgets);
  });

  testWidgets('Page should display error text when on the air data is error',
      (WidgetTester tester) async {
    when(mockNotifier.onTheAirState).thenReturn(RequestState.Error);
    when(mockNotifier.popularTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularTv).thenReturn(testTvList);
    when(mockNotifier.topRatedTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedTv).thenReturn(testTvList);

    await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('Page should display TvList when popular data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.onTheAirState).thenReturn(RequestState.Loaded);
    when(mockNotifier.onTheAirTv).thenReturn(testTvList);
    when(mockNotifier.popularTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularTv).thenReturn(testTvList);
    when(mockNotifier.topRatedTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedTv).thenReturn(testTvList);

    await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

    expect(find.byType(ListView), findsWidgets);
  });

  testWidgets('Page should display error text when popular data is error',
      (WidgetTester tester) async {
    when(mockNotifier.onTheAirState).thenReturn(RequestState.Loaded);
    when(mockNotifier.onTheAirTv).thenReturn(testTvList);
    when(mockNotifier.popularTvState).thenReturn(RequestState.Error);
    when(mockNotifier.topRatedTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedTv).thenReturn(testTvList);

    await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('Page should display TvList when top rated data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.onTheAirState).thenReturn(RequestState.Loaded);
    when(mockNotifier.onTheAirTv).thenReturn(testTvList);
    when(mockNotifier.popularTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularTv).thenReturn(testTvList);
    when(mockNotifier.topRatedTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedTv).thenReturn(testTvList);

    await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

    expect(find.byType(ListView), findsWidgets);
  });

  testWidgets('Page should display error text when top rated data is error',
      (WidgetTester tester) async {
    when(mockNotifier.onTheAirState).thenReturn(RequestState.Loaded);
    when(mockNotifier.onTheAirTv).thenReturn(testTvList);
    when(mockNotifier.popularTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularTv).thenReturn(testTvList);
    when(mockNotifier.topRatedTvState).thenReturn(RequestState.Error);

    await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

    expect(find.text('Failed'), findsOneWidget);
  });
}
