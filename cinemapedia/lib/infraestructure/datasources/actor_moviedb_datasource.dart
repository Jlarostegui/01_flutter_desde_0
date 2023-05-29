import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infraestructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infraestructure/models/models.dart';
import 'package:dio/dio.dart';

import 'dart:developer' as dev;

class ActorMovieDbDataSource extends ActorsDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.baseUrl,
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-ES'
      },
    ),
  );

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    dev.log('${UrlMovies.movie.value}$movieId${UrlMovies.credits.value}');
    final response = await dio
        .get('${UrlMovies.movie.value}$movieId${UrlMovies.credits.value}');

    final creditsResponse = CreditsResponse.fromJson(response.data);
    List<Actor> actors = creditsResponse.cast
        .map((actor) => ActorMapper.castToEntity(actor))
        .toList();
    return actors;
  }
}
