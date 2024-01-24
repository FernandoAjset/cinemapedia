import 'dart:io';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infraestructure/models/movieDb_response.dart';
import 'package:cinemapedia/infraestructure/models/movie_details.dart';
import 'package:dio/dio.dart';
import 'package:ansicolor/ansicolor.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': 'es-MX'
      }));

  List<Movie> _jsonToMovie(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDbToEntity(moviedb))
        .toList();

    return movies;
  }

  Future<Response?> _makeRequest(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    Response? response;
    AnsiPen pen = AnsiPen()..red(bold: true);
    for (int i = 0; i < 3; i++) {
      try {
        response = await dio.get(endpoint, queryParameters: queryParams);
        break;
      } catch (e) {
        if (e is DioError && e.error is SocketException) {
          print(pen('Attempt $i: Failed to load $endpoint'));
          await Future.delayed(const Duration(seconds: 1));
        } else {
          rethrow;
        }
      }
    }

    if (response == null) {
      throw Exception('Failed to load $endpoint after 3 attempts.');
    }

    return response;
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await _makeRequest('/movie/top_rated', queryParams: {'page': page});
    return response != null ? _jsonToMovie(response.data!) : [];
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await _makeRequest('/movie/$id');

    if (response?.statusCode != 200) {
      throw Exception('Movie with id:$id not found!');
    }
    final movieDetails = MovieDetails.fromJson(response!.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }

  @override
  Future<List<Movie>> getMovieBySearchParam(String param) async {
    if (param.isEmpty) return [];
    final response =
        await _makeRequest('/search/movie', queryParams: {'query': param});
    return response != null ? _jsonToMovie(response.data!) : [];
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1}) async {
    final response =
        await _makeRequest('/movie/upcoming', queryParams: {'page': page});
    return response != null ? _jsonToMovie(response.data!) : [];
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await _makeRequest('/movie/now_playing', queryParams: {'page': page});
    return response != null ? _jsonToMovie(response.data!) : [];
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await _makeRequest('/movie/popular', queryParams: {'page': page});
    return response != null ? _jsonToMovie(response.data!) : [];
  }
}