import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/components/base/base_consumer_state.dart';
import 'package:movie_app/src/components/widgets/movie_list_tile.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/providers/view_model_providers.dart';
import 'package:movie_app/src/routes/routes.dart';
import 'package:movie_app/src/ui/add_movie/add_movie.dart';
import 'package:movie_app/src/ui/dashboard/movie_dashboard_vm.dart';
import 'package:movie_app/src/ui/dashboard_provider/dashboard_provider_notifier.dart';

class DashboardProvider extends ConsumerStatefulWidget {
  const DashboardProvider({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardProviderState();
}

class _DashboardProviderState
    extends BaseConsumerState<DashboardProvider, MovieDashboardVm> {
  @override
  Widget build(BuildContext context) {
    final List<Movie> movieService = ref.watch(movieProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Provider"),
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
                    ref.read(movieProvider.notifier).add(result);
                  }
                },
                child: const Icon(Icons.add)),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        itemCount: movieService.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final Movie movie = movieService[index];

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
  }

  @override
  MovieDashboardVm createModel() {
    return ref.read(movieDashboardProvider);
  }
}
