import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/network/movie_service.dart';

class MovieNotifier extends StateNotifier<List<Movie>> {
  List<Movie> movie = [];

  MovieNotifier(List<Movie>? state) : super(state ?? <Movie>[]);

  void add(Movie addMovie) {
    state = [...state, addMovie];
  }
}

final StateNotifierProvider<MovieNotifier, List<Movie>> movieProvider =
    StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  final AsyncValue<List<Movie>> dataFuture = ref.watch(moviesFutureProvider);
  final List<Movie>? initialData = dataFuture.value; // future provider
  return MovieNotifier(initialData);
});

FutureProvider<List<Movie>> moviesFutureProvider =
    FutureProvider<List<Movie>>((ref) async {
  MovieService movieService = ref.read(movieServiceProvider);
  List<Movie> movies = await movieService.getMovies();

  return movies;
});
