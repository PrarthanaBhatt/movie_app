import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/network/movie_service.dart';

class MovieNotifier extends StateNotifier<List<Movie>> {
  List<Movie> movie = [];

  // MovieNotifier(super.state);
  MovieNotifier() : super([]);

  // MovieNotifier([List<Movie>? state]) : super(state ?? <Movie>[]);

  void add(Movie addMovie) {
    state = [...state, addMovie];
  }
}

final a = StateNotifierProvider<StateNotifier<int>, int>(
    (ref) => 1 as StateNotifier<int>);

final movieProvider = StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  return MovieNotifier();
});

FutureProvider<List<Movie>> moviesFutureProvider =
    FutureProvider<List<Movie>>((ref) async {
  MovieService movieService = ref.read(movieServiceProvider);
  List<Movie> movies = await movieService.getMovies();

  return movies;
});
