import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/on_the_air_tv/on_the_air_tv_bloc.dart';
import 'package:ditonton/presentation/pages/on_the_air_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnTheAirTvBloc extends MockBloc<OnTheAirTvEvent, OnTheAirTvState>
    implements OnTheAirTvBloc {}

void main() {
  late MockOnTheAirTvBloc mockBloc;

  setUp(() {
    mockBloc = MockOnTheAirTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<OnTheAirTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading', (
    WidgetTester tester,
  ) async {
    when(() => mockBloc.state).thenReturn(OnTheAirTvLoading());

    await tester.pumpWidget(makeTestableWidget(OnTheAirTvPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (
    WidgetTester tester,
  ) async {
    when(() => mockBloc.state).thenReturn(const OnTheAirTvLoaded(<Tv>[]));

    await tester.pumpWidget(makeTestableWidget(OnTheAirTvPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (
    WidgetTester tester,
  ) async {
    when(
      () => mockBloc.state,
    ).thenReturn(const OnTheAirTvError('Error message'));

    await tester.pumpWidget(makeTestableWidget(OnTheAirTvPage()));

    expect(find.byKey(const Key('error_message')), findsOneWidget);
  });
}
