import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirTv, GetPopularTv, GetTopRatedTv])
void main() {
  late TvListBloc bloc;
  late MockGetOnTheAirTv mockGetOnTheAirTv;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    bloc = TvListBloc(
      getOnTheAirTv: mockGetOnTheAirTv,
      getPopularTv: mockGetPopularTv,
      getTopRatedTv: mockGetTopRatedTv,
    );
  });

  final tTvList = <Tv>[];

  group('on the air tv', () {
    blocTest<TvListBloc, TvListState>(
      'should emit Loading then Loaded when data is gotten successfully',
      build: () {
        when(
          mockGetOnTheAirTv.execute(),
        ).thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchOnTheAirTv()),
      expect: () => [
        const TvListState().copyWith(onTheAirState: RequestState.Loading),
        const TvListState().copyWith(
          onTheAirState: RequestState.Loaded,
          onTheAirTv: tTvList,
        ),
      ],
    );

    blocTest<TvListBloc, TvListState>(
      'should emit Loading then Error when get data is unsuccessful',
      build: () {
        when(
          mockGetOnTheAirTv.execute(),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchOnTheAirTv()),
      expect: () => [
        const TvListState().copyWith(onTheAirState: RequestState.Loading),
        const TvListState().copyWith(
          onTheAirState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('popular tv', () {
    blocTest<TvListBloc, TvListState>(
      'should emit Loading then Loaded when data is gotten successfully',
      build: () {
        when(
          mockGetPopularTv.execute(),
        ).thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularTv()),
      expect: () => [
        const TvListState().copyWith(popularTvState: RequestState.Loading),
        const TvListState().copyWith(
          popularTvState: RequestState.Loaded,
          popularTv: tTvList,
        ),
      ],
    );

    blocTest<TvListBloc, TvListState>(
      'should emit Loading then Error when get data is unsuccessful',
      build: () {
        when(
          mockGetPopularTv.execute(),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularTv()),
      expect: () => [
        const TvListState().copyWith(popularTvState: RequestState.Loading),
        const TvListState().copyWith(
          popularTvState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('top rated tv', () {
    blocTest<TvListBloc, TvListState>(
      'should emit Loading then Loaded when data is gotten successfully',
      build: () {
        when(
          mockGetTopRatedTv.execute(),
        ).thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTv()),
      expect: () => [
        const TvListState().copyWith(topRatedTvState: RequestState.Loading),
        const TvListState().copyWith(
          topRatedTvState: RequestState.Loaded,
          topRatedTv: tTvList,
        ),
      ],
    );

    blocTest<TvListBloc, TvListState>(
      'should emit Loading then Error when get data is unsuccessful',
      build: () {
        when(
          mockGetTopRatedTv.execute(),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTv()),
      expect: () => [
        const TvListState().copyWith(topRatedTvState: RequestState.Loading),
        const TvListState().copyWith(
          topRatedTvState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });
}
