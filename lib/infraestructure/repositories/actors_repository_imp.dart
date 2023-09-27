import 'package:cinemapedia/domain/datasources/actors_datasources.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorsRepositoryImp implements ActorsRepository {
  final ActorsDatasource _datasource;

  ActorsRepositoryImp(this._datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String id) {
    return _datasource.getActorsByMovie(id);
  }
}
