import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/network/movie_exception.dart';
import 'package:movie_app/src/network/movie_service.dart';
import 'package:movie_app/src/routes/routes.dart';

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
        ),
        body: ref.watch(moviesFutureProvider).when(
              error: (e, s) {
                if (e is MoviesException) {
                  return _ErrorBody(message: '${e.message}');
                }
                return const _ErrorBody(
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
                              // "voteAverage": movie.voteAverage.toString(),
                              "originalTitle": movie.originalTitle
                            },
                          );
                        },
                        child: _MovieBox(movie: movie),
                      );
                    },
                  ),
                );
              },
            ));
  }
}

class _ErrorBody extends ConsumerWidget {
  const _ErrorBody({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ElevatedButton(
            onPressed: () => ref.refresh(moviesFutureProvider),
            child: const Text("Try again"),
          ),
        ],
      ),
    );
  }
}

class _MovieBox extends StatelessWidget {
  final Movie movie;

  const _MovieBox({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
              movie.fullImageUrl,
              fit: BoxFit.cover,
              width: double.maxFinite,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _FrontBanner(text: movie.title),
          ),
        ],
      ),
    );
  }
}

class _FrontBanner extends StatelessWidget {
  const _FrontBanner({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            color: Colors.grey.shade200.withOpacity(0.5),
            height: 60,
            child: Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
