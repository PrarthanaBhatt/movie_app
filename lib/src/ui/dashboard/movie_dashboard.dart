import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/components/base/base_consumer_state.dart';
import 'package:movie_app/src/components/widgets/error_body.dart';
import 'package:movie_app/src/components/widgets/movie_list_tile.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/network/movie_exception.dart';
import 'package:movie_app/src/network/movie_service.dart';
import 'package:movie_app/src/providers/view_model_providers.dart';
import 'package:movie_app/src/routes/routes.dart';
import 'package:movie_app/src/ui/add_movie/add_movie.dart';
import 'package:movie_app/src/ui/dashboard/movie_dashboard_vm.dart';

FutureProvider<List<Movie>> moviesFutureProvider =
    FutureProvider<List<Movie>>((ref) async {
  MovieService movieService = ref.read(movieServiceProvider);
  List<Movie> movies = await movieService.getMovies();

  return movies;
});

class MovieDashboard extends ConsumerStatefulWidget {
  const MovieDashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieDashboardState();
}

class _MovieDashboardState
    extends BaseConsumerState<MovieDashboard, MovieDashboardVm> {
  @override
  Widget build(BuildContext context) {
    MovieService movieService = ref.read(movieServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.black45,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
                onTap: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddMovie()),
                  );

                  if (result != null) {
                    print('Received data: ${result.toJson()}');
                    final List<Movie> updatedList =
                        await movieService.getMovies();
                    movieService.getValue(result, updatedList);
                    ref.refresh(moviesFutureProvider);
                    print(
                        'Get Value Result: ${movieService.getValue(result, updatedList)}');
                  }
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
              print(movies);
              return RefreshIndicator(
                onRefresh: () async {
                  return ref.refresh(moviesFutureProvider);
                },
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  itemCount: movies.length,
                  // itemCount: 18,
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
          ),
    );
  }

  @override
  MovieDashboardVm createModel() {
    return ref.read(movieDashboardProvider);
  }
}
