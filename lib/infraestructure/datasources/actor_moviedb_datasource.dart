import 'package:cinemapedia/domain/datasources/actors_datasources.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infraestructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infraestructure/models/credits_response.dart';
import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';

class ActorMovieDbDataSource implements ActorsDatasource {
  final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      maxRedirects: 10,
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': 'es-MX'
      }));

  List<Actor> _jsonToActor(Map<String, dynamic> json) {
    final actorsDBResponse = CreditsResponse.fromJson(json);
// obtener la lista de Cast desde la respuesta de fromJson y usando el mapper
// pasar a una lista de actores
    final List<Actor> actors = actorsDBResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();
    return actors;
  }

  @override
  Future<List<Actor>> getActorsByMovie(String id) async {
    final response = await dio.get('/movie/$id/credits');
    return _jsonToActor(response.data);
  }
}
