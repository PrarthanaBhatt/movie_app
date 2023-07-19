import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/src/models/movie.dart';

class MovieNotifier extends StateNotifier<List<Movie>> {
  List<Movie> movie = [];

  MovieNotifier(super.state);

  void add(Movie todo) {
    state = [...state, todo];
  }
}

final a = StateNotifierProvider<StateNotifier<int>, int>(
    (ref) => 1 as StateNotifier<int>);



// final todosProvider = StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
//   return MovieNotifier();
// });
