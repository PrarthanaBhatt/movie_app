import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/network/movie_exception.dart';
import 'package:movie_app/src/utils/helpers/movie_sql_helper.dart';

final Provider<MovieService> movieServiceProvider =
    Provider<MovieService>((ref) {
  return MovieService();
});

class MovieService {
  Dio? _dio;
  Movie? resultVal;
  List<Movie?>? getList;

  MovieService() {
    _dio = Dio();
  }

  Future<List<Movie>> getMovies() async {
    try {
      final response = await _dio!.get(
        // ${_enviromentConfig.movieApiKey}

        "https://api.themoviedb.org/3/movie/popular?api_key=e1eb9d73afc601612fb492d7f0e060aa&language=en-US&page=1",
      );

      final List<Map<String, dynamic>> results =
          List<Map<String, dynamic>>.from(response.data['results']);

      MovieSQLHelper.deleteItems();

      if (results.isNotEmpty) {
        for (var item in results) {
          await MovieSQLHelper.createItem(
              item['title'],
              item['poster_path'],
              item['overview'],
              item['backdrop_path'],
              item['release_date'],
              item['original_language'],
              item['original_title']);
          print("Result ===> $results");
        }
      }

      MovieSQLHelper.getItems();

      //INFO: When to load the API response from provider use below
      // List<Movie> movies =
      // results.map((movieData) => Movie.fromMap(movieData)).toList();

      // return movies;

      //INFO: When to load the API response from SQLite

      final Future<List<Movie>> data =
          MovieSQLHelper.getItems() as Future<List<Movie>>;

      return data;
    } on DioException catch (dioError) {
      throw MoviesException.fromDioError(dioError);
    }
  }

  Movie? getValue(Movie result) {
    resultVal = result;
    return resultVal;
  }
}
