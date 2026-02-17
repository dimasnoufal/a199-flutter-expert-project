import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetTvWatchListStatus,
  SaveTvWatchlist,
  RemoveTvWatchlist,
])
void main() {
  late TvDetailBloc bloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetTvWatchListStatus mockGetTvWatchListStatus;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetTvWatchListStatus = MockGetTvWatchListStatus();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    bloc = TvDetailBloc(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getTvWatchListStatus: mockGetTvWatchListStatus,
      saveTvWatchlist: mockSaveTvWatchlist,
      removeTvWatchlist: mockRemoveTvWatchlist,
    );
  });

  const tId = 1;
  final tTvList = <Tv>[];

  group('Get TV Detail', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit Loading, then Loaded with recommendations when data is gotten successfully',
      build: () {
        when(
          mockGetTvDetail.execute(tId),
        ).thenAnswer((_) async => Right(testTvDetail));
        when(
          mockGetTvRecommendations.execute(tId),
        ).thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchTvDetail(tId)),
      expect: () => [
        const TvDetailState().copyWith(tvState: RequestState.Loading),
        const TvDetailState().copyWith(
          tvState: RequestState.Loaded,
          tv: testTvDetail,
          recommendationState: RequestState.Loading,
        ),
        const TvDetailState().copyWith(
          tvState: RequestState.Loaded,
          tv: testTvDetail,
          recommendationState: RequestState.Loaded,
          tvRecommendations: tTvList,
        ),
      ],
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit Loading then Error when get detail fails',
      build: () {
        when(
          mockGetTvDetail.execute(tId),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(
          mockGetTvRecommendations.execute(tId),
        ).thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchTvDetail(tId)),
      expect: () => [
        const TvDetailState().copyWith(tvState: RequestState.Loading),
        const TvDetailState().copyWith(
          tvState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit Loaded detail and Error recommendations when recommendations fail',
      build: () {
        when(
          mockGetTvDetail.execute(tId),
        ).thenAnswer((_) async => Right(testTvDetail));
        when(
          mockGetTvRecommendations.execute(tId),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchTvDetail(tId)),
      expect: () => [
        const TvDetailState().copyWith(tvState: RequestState.Loading),
        const TvDetailState().copyWith(
          tvState: RequestState.Loaded,
          tv: testTvDetail,
          recommendationState: RequestState.Loading,
        ),
        const TvDetailState().copyWith(
          tvState: RequestState.Loaded,
          tv: testTvDetail,
          recommendationState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('Watchlist', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit watchlistMessage and update isAddedToWatchlist when add watchlist success',
      build: () {
        when(
          mockSaveTvWatchlist.execute(testTvDetail),
        ).thenAnswer((_) async => const Right('Added to Watchlist'));
        when(
          mockGetTvWatchListStatus.execute(testTvDetail.id),
        ).thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(AddTvToWatchlist(testTvDetail)),
      expect: () => [
        const TvDetailState().copyWith(watchlistMessage: 'Added to Watchlist'),
        const TvDetailState().copyWith(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit watchlistMessage and update isAddedToWatchlist when remove watchlist success',
      build: () {
        when(
          mockRemoveTvWatchlist.execute(testTvDetail),
        ).thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(
          mockGetTvWatchListStatus.execute(testTvDetail.id),
        ).thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(RemoveTvFromWatchlist(testTvDetail)),
      expect: () => [
        const TvDetailState().copyWith(
          watchlistMessage: 'Removed from Watchlist',
        ),
      ],
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit watchlistMessage failure when add watchlist fails',
      build: () {
        when(
          mockSaveTvWatchlist.execute(testTvDetail),
        ).thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        when(
          mockGetTvWatchListStatus.execute(testTvDetail.id),
        ).thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(AddTvToWatchlist(testTvDetail)),
      expect: () => [
        const TvDetailState().copyWith(watchlistMessage: 'Database Failure'),
      ],
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit correct isAddedToWatchlist',
      build: () {
        when(
          mockGetTvWatchListStatus.execute(tId),
        ).thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadTvWatchlistStatus(tId)),
      expect: () => [const TvDetailState().copyWith(isAddedToWatchlist: true)],
    );
  });
}
