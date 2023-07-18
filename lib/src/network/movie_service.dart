import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/network/movie_exception.dart';

final movieServiceProvider = Provider<MovieService>((ref) {
  return MovieService();
});

class MovieService {
  Dio? _dio;
  Movie? resultVal;

  MovieService() {
    _dio = Dio();
  }

  Future<List<Movie>> getMovies() async {
    try {
      final response = await _dio!.get(
        // ${_enviromentConfig.movieApiKey}

        "https://api.themoviedb.org/3/movie/popular?api_key=e1eb9d73afc601612fb492d7f0e060aa&language=en-US&page=1",
      );

      final results = List<Map<String, dynamic>>.from(response.data['results']);

      List<Movie> movies = results
          .map((movieData) => Movie.fromMap(movieData))
          .toList(growable: false);

      return movies;
    } on DioError catch (dioError) {
      throw MoviesException.fromDioError(dioError);
    }
  }

  getValue(Movie result, List<Movie?> updatedList) {
    resultVal = result;
    updatedList = updatedList.toList();

    updatedList.add(resultVal);
    return updatedList;
  }
}
