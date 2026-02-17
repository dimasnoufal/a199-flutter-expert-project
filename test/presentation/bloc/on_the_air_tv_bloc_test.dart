import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:ditonton/presentation/bloc/on_the_air_tv/on_the_air_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'on_the_air_tv_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirTv])
void main() {
  late OnTheAirTvBloc bloc;
  late MockGetOnTheAirTv mockGetOnTheAirTv;

  setUp(() {
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    bloc = OnTheAirTvBloc(mockGetOnTheAirTv);
  });

  final tTvList = <Tv>[];

  test('initial state should be empty', () {
    expect(bloc.state, OnTheAirTvEmpty());
  });

  blocTest<OnTheAirTvBloc, OnTheAirTvState>(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetOnTheAirTv.execute()).thenAnswer((_) async => Right(tTvList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTv()),
    expect: () => [OnTheAirTvLoading(), OnTheAirTvLoaded(tTvList)],
    verify: (_) {
      verify(mockGetOnTheAirTv.execute());
    },
  );

  blocTest<OnTheAirTvBloc, OnTheAirTvState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(
        mockGetOnTheAirTv.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTv()),
    expect: () => [
      OnTheAirTvLoading(),
      const OnTheAirTvError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetOnTheAirTv.execute());
    },
  );
}
