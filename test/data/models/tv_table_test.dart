import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvTable = TvTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  final tTv = Tv.watchlist(
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'name',
  );

  test('should be a subclass of Tv entity', () async {
    final result = tTvTable.toEntity();
    expect(result, tTv);
  });

  group('fromEntity', () {
    final tTvDetail = TvDetail(
      backdropPath: 'backdropPath',
      genres: [],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      posterPath: 'posterPath',
      firstAirDate: 'firstAirDate',
      name: 'name',
      numberOfEpisodes: 10,
      numberOfSeasons: 1,
      voteAverage: 1,
      voteCount: 1,
    );

    test('should convert from TvDetail entity', () {
      final result = TvTable.fromEntity(tTvDetail);
      expect(result, tTvTable);
    });
  });

  group('fromMap', () {
    test('should return a valid model from map', () async {
      final Map<String, dynamic> map = {
        'id': 1,
        'name': 'name',
        'posterPath': 'posterPath',
        'overview': 'overview',
      };

      final result = TvTable.fromMap(map);

      expect(result, tTvTable);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tTvTable.toJson();

      final expectedMap = {
        'id': 1,
        'name': 'name',
        'posterPath': 'posterPath',
        'overview': 'overview',
      };
      expect(result, expectedMap);
    });
  });
}
