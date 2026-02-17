import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTv(mockTvRepository);
  });

  final tTvList = <Tv>[];
  final tQuery = 'Spider-Man';

  test('should get list of tv from the repository', () async {
    when(mockTvRepository.searchTv(tQuery))
        .thenAnswer((_) async => Right(tTvList));
    final result = await usecase.execute(tQuery);
    expect(result, Right(tTvList));
  });
}
