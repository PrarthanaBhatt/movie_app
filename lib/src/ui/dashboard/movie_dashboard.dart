import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/network/movie_exception.dart';
import 'package:movie_app/src/network/movie_service.dart';
import 'package:movie_app/src/routes/routes.dart';
import 'package:movie_app/src/components/widgets/movie_list_tile.dart';
import 'package:movie_app/src/components/widgets/error_body.dart';

final moviesFutureProvider =
    FutureProvider.autoDispose<List<Movie>>((ref) async {
  ref.maintainState = true;

  final movieService = ref.read(movieServiceProvider);
  final movies = await movieService.getMovies();

  return movies;
});

class MovieDashboard extends ConsumerWidget {
  const MovieDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: Colors.black45,
          actions: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('clicked ')),
                    );
                  },
                  child: const Icon(Icons.add)),
            ),
          ],
        ),
        body: ref.watch(moviesFutureProvider).when(
              error: (e, s) {
                if (e is MoviesException) {
                  return ErrorBody(message: '${e.message}');
                }
                return const ErrorBody(
                    message: "Oops, something unexpected happened");
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              data: (movies) {
                return RefreshIndicator(
                  onRefresh: () async {
                    return ref.refresh(moviesFutureProvider);
                  },
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    itemCount: movies.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final movie = movies[index];

                      return GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            Routes.movieDetails,
                            pathParameters: {
                              "overview": movie.overview,
                              "backdropPath": movie.fullBannerImageUrl,
                              "releaseDate": movie.releaseDate,
                              "originalLanguage": movie.originalLanguage,
                              "originalTitle": movie.originalTitle
                            },
                          );
                        },
                        child: MovieListTile(movie: movie),
                      );
                    },
                  ),
                );
              },
            ));
  }
}
