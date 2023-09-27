
import 'package:cinemapedia/infraestructure/repositories/actors_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infraestructure/datasources/actor_moviedb_datasource.dart';

final actorsRepositoryProvider = Provider((ref) {
  final actorsDatasource = ActorMovieDbDataSource();
  return ActorsRepositoryImp(actorsDatasource);
});
