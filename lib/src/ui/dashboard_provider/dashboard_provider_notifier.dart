import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/network/movie_service.dart';

class MovieNotifier extends StateNotifier<List<Movie>> {
  List<Movie> movie = [];

  MovieNotifier(List<Movie>? state) : super(state ?? <Movie>[]);

  void add(Movie addMovie) {
    // Since our state is immutable, we are not allowed to do `state.add(todo)`.
    // Instead, we should create a new list of todos which contains the previous
    // items and the new one.
    // Using Dart's spread operator here is helpful!
    state = [...state, addMovie];
  }
}

//Note: ProviderRef allows us to communicate from one provider to other provider
final StateNotifierProvider<MovieNotifier, List<Movie>> movieProvider =
    StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  final AsyncValue<List<Movie>> dataFuture = ref.watch(moviesFutureProvider);
  return MovieNotifier(dataFuture.value);
});

FutureProvider<List<Movie>> moviesFutureProvider =
    FutureProvider<List<Movie>>((ref) async {
  MovieService movieService = ref.read(movieServiceProvider);
  List<Movie> movies = await movieService.getMovies();

  return movies;
});
