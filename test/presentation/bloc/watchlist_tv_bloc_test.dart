import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late WatchlistTvBloc bloc;
  late MockGetWatchlistTv mockGetWatchlistTv;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    bloc = WatchlistTvBloc(getWatchlistTv: mockGetWatchlistTv);
  });

  final tTvList = <Tv>[];

  test('initial state should be empty', () {
    expect(bloc.state, WatchlistTvEmpty());
  });

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(
        mockGetWatchlistTv.execute(),
      ).thenAnswer((_) async => Right(tTvList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTv()),
    expect: () => [WatchlistTvLoading(), WatchlistTvLoaded(tTvList)],
    verify: (_) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(
        mockGetWatchlistTv.execute(),
      ).thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTv()),
    expect: () => [
      WatchlistTvLoading(),
      const WatchlistTvError('Database Failure'),
    ],
    verify: (_) {
      verify(mockGetWatchlistTv.execute());
    },
  );
}
