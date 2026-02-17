import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late TvSearchBloc bloc;
  late MockSearchTv mockSearchTv;

  setUp(() {
    mockSearchTv = MockSearchTv();
    bloc = TvSearchBloc(searchTv: mockSearchTv);
  });

  const tQuery = 'breaking bad';
  final tTvList = <Tv>[];

  test('initial state should be empty', () {
    expect(bloc.state, TvSearchEmpty());
  });

  blocTest<TvSearchBloc, TvSearchState>(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(
        mockSearchTv.execute(tQuery),
      ).thenAnswer((_) async => Right(tTvList));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnTvQueryChanged(tQuery)),
    expect: () => [TvSearchLoading(), TvSearchLoaded(tTvList)],
    verify: (_) {
      verify(mockSearchTv.execute(tQuery));
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(
        mockSearchTv.execute(tQuery),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnTvQueryChanged(tQuery)),
    expect: () => [TvSearchLoading(), const TvSearchError('Server Failure')],
    verify: (_) {
      verify(mockSearchTv.execute(tQuery));
    },
  );
}
