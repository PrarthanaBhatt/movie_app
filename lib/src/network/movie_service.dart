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

      for (var item in results) {
        MovieSQLHelper.createItem(item['title'], item['posterPath']);
        print("Result ===> $results");
      }

      List<Movie> movies =
          results.map((movieData) => Movie.fromMap(movieData)).toList();

      final Future<List<Movie>> data =
          MovieSQLHelper.getItems() as Future<List<Movie>>;

      // if (resultVal != null) {
      //   movies.add(resultVal!);
      // }
      // return movies;

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
