import 'package:cinemapedia/domain/entities/movie.dart';

import '../../domain/datasources/Movie_datasource.dart';
import '../../domain/repositories/Movie_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;
  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
}
