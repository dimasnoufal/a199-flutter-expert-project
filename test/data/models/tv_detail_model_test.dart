import 'dart:convert';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvDetailResponse = TvDetailResponse(
    backdropPath: "/path.jpg",
    genres: [GenreModel(id: 1, name: "Action")],
    homepage: "https://google.com",
    id: 1,
    originalLanguage: "en",
    originalName: "Original TV Detail Name",
    overview: "TV Detail Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    firstAirDate: "2020-05-05",
    name: "TV Detail Name",
    numberOfEpisodes: 10,
    numberOfSeasons: 1,
    status: "Returning Series",
    tagline: "TV Tagline",
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_detail.json'));

      final result = TvDetailResponse.fromJson(jsonMap);

      expect(result, tTvDetailResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tTvDetailResponse.toJson();

      final expectedJsonMap = {
        "backdrop_path": "/path.jpg",
        "genres": [
          {"id": 1, "name": "Action"}
        ],
        "homepage": "https://google.com",
        "id": 1,
        "original_language": "en",
        "original_name": "Original TV Detail Name",
        "overview": "TV Detail Overview",
        "popularity": 1.0,
        "poster_path": "/path.jpg",
        "first_air_date": "2020-05-05",
        "name": "TV Detail Name",
        "number_of_episodes": 10,
        "number_of_seasons": 1,
        "status": "Returning Series",
        "tagline": "TV Tagline",
        "vote_average": 1.0,
        "vote_count": 1,
      };
      expect(result, expectedJsonMap);
    });
  });

  group('toEntity', () {
    test('should be a subclass of TvDetail entity', () async {
      final result = tTvDetailResponse.toEntity();

      expect(result.id, 1);
      expect(result.name, "TV Detail Name");
    });
  });
}
