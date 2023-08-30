import 'package:cinemapedia/domain/entities/movie.dart';

abstract class IMovieRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
