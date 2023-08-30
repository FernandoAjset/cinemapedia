import 'package:cinemapedia/domain/entities/movie.dart';

abstract class IMovieDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
