import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnTheAirTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetOnTheAirTv(mockTvRepository);
  });

  final tTvList = <Tv>[];

  test('should get list of tv from the repository', () async {
    when(mockTvRepository.getOnTheAirTv())
        .thenAnswer((_) async => Right(tTvList));
    final result = await usecase.execute();
    expect(result, Right(tTvList));
  });
}
