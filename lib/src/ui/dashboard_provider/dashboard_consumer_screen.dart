// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:movie_app/src/components/base/base_consumer_state.dart';
// import 'package:movie_app/src/components/widgets/movie_list_tile.dart';
// import 'package:movie_app/src/models/movie.dart';
// import 'package:movie_app/src/providers/view_model_providers.dart';
// import 'package:movie_app/src/routes/routes.dart';
// import 'package:movie_app/src/ui/add_movie/add_movie.dart';
// import 'package:movie_app/src/ui/dashboard/movie_dashboard_vm.dart';
// import 'package:movie_app/src/ui/dashboard_provider/dashboard_provider_notifier.dart';

// class DashboardConsumerScreen extends ConsumerStatefulWidget {
//   const DashboardConsumerScreen({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _DashboardConsumerState();
// }

// class _DashboardConsumerState
//     extends BaseConsumerState<DashboardConsumerScreen, MovieDashboardVm> {
//   @override
//   Widget build(BuildContext context) {
//     print("Rebuild...");
//     final List<Movie> movieService = ref.watch(movieProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Dashboard Provider"),
//         backgroundColor: Colors.black45,
//         actions: [
//           Consumer(builder: (context, ref, child) {
//             return Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: GestureDetector(
//                   onTap: () async {
//                     var result = await Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const AddMovie()),
//                     );

//                     if (result != null) {
//                       ref.read(movieProvider.notifier).add(result);
//                     }
//                   },
//                   child: const Icon(Icons.add)),
//             );
//           }),
//         ],
//       ),
//       body: Consumer(builder: (context, ref, child) {
//         return ListView.builder(
//           padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//           itemCount: movieService.length,
//           shrinkWrap: true,
//           itemBuilder: (context, index) {
//             final Movie movie = movieService[index];

//             return GestureDetector(
//               onTap: () {
//                 context.pushNamed(
//                   Routes.movieDetails,
//                   pathParameters: {
//                     "overview": movie.overview,
//                     "backdropPath": movie.fullBannerImageUrl,
//                     "releaseDate": movie.releaseDate,
//                     "originalLanguage": movie.originalLanguage,
//                     "originalTitle": movie.originalTitle
//                   },
//                 );
//               },
//               child: MovieListTile(movie: movie),
//             );
//           },
//         );
//       }),
//     );
//   }

//   @override
//   MovieDashboardVm createModel() {
//     return ref.read(movieDashboardProvider);
//   }
// }

///-----------------------------------------------------------
///below code when consumer and statelesswidget is used
///-----------------------------------------------------------

// ///Below code when Consumer and StatelessWidget is used to consume provider value
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:movie_app/src/components/widgets/movie_list_tile.dart';
// import 'package:movie_app/src/models/movie.dart';
// import 'package:movie_app/src/routes/routes.dart';
// import 'package:movie_app/src/ui/add_movie/add_movie.dart';
// import 'package:movie_app/src/ui/dashboard_provider/dashboard_provider_notifier.dart';

// class DashboardConsumerScreen extends StatelessWidget {
//   const DashboardConsumerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     print("Rebuild .....");
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Dashboard Provider"),
//         backgroundColor: Colors.black45,
//         actions: [
//           Consumer(builder: (context, ref, child) {
//             return Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: GestureDetector(
//                   onTap: () async {
//                     var result = await Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const AddMovie()),
//                     );

//                     if (result != null) {
//                       ref.read(movieProvider.notifier).add(result);
//                     }
//                   },
//                   child: const Icon(Icons.add)),
//             );
//           }),
//         ],
//       ),
//       body: Consumer(builder: (context, ref, child) {
//         final List<Movie> movieService = ref.watch(movieProvider);

//         return ListView.builder(
//           padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//           itemCount: movieService.length,
//           shrinkWrap: true,
//           itemBuilder: (context, index) {
//             final Movie movie = movieService[index];

//             return GestureDetector(
//               onTap: () {
//                 context.pushNamed(
//                   Routes.movieDetails,
//                   pathParameters: {
//                     "overview": movie.overview,
//                     "backdropPath": movie.fullBannerImageUrl,
//                     "releaseDate": movie.releaseDate,
//                     "originalLanguage": movie.originalLanguage,
//                     "originalTitle": movie.originalTitle
//                   },
//                 );
//               },
//               child: MovieListTile(movie: movie),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

///-----------------------------------------------------------
///Below code when Consumer and StatefullWidget is used to consume provider value
///-----------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:movie_app/src/components/widgets/movie_list_tile.dart';
// import 'package:movie_app/src/models/movie.dart';
// import 'package:movie_app/src/routes/routes.dart';
// import 'package:movie_app/src/ui/add_movie/add_movie.dart';
// import 'package:movie_app/src/ui/dashboard_provider/dashboard_provider_notifier.dart';

// class DashboardConsumerScreen extends StatefulWidget {
//   const DashboardConsumerScreen({super.key});

//   @override
//   State<DashboardConsumerScreen> createState() =>
//       _DashboardConsumerScreenState();
// }

// class _DashboardConsumerScreenState extends State<DashboardConsumerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     print("Rebuild .....");

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Dashboard Provider"),
//         backgroundColor: Colors.black45,
//         actions: [
//           Consumer(builder: (context, ref, child) {
//             return Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: GestureDetector(
//                   onTap: () async {
//                     var result = await Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const AddMovie()),
//                     );

//                     if (result != null) {
//                       ref.read(movieProvider.notifier).add(result);
//                     }
//                   },
//                   child: const Icon(Icons.add)),
//             );
//           }),
//         ],
//       ),
//       body: Consumer(builder: (context, ref, child) {
//         final List<Movie> movieService = ref.watch(movieProvider);

//         return ListView.builder(
//           padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//           itemCount: movieService.length,
//           shrinkWrap: true,
//           itemBuilder: (context, index) {
//             final Movie movie = movieService[index];

//             return GestureDetector(
//               onTap: () {
//                 context.pushNamed(
//                   Routes.movieDetails,
//                   pathParameters: {
//                     "overview": movie.overview,
//                     "backdropPath": movie.fullBannerImageUrl,
//                     "releaseDate": movie.releaseDate,
//                     "originalLanguage": movie.originalLanguage,
//                     "originalTitle": movie.originalTitle
//                   },
//                 );
//               },
//               child: MovieListTile(movie: movie),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

///-----------------------------------------------------------
///below code when rebuild issue can be resolved when divided into chunks
///ConsumerStatefulWidget
///-----------------------------------------------------------
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

class DashboardConsumerScreen extends ConsumerStatefulWidget {
  const DashboardConsumerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardConsumerState();
}

class _DashboardConsumerState
    extends BaseConsumerState<DashboardConsumerScreen, MovieDashboardVm> {
  @override
  Widget build(BuildContext context) {
    print("Parent Rebuild...");

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
      body: const MovieList(),
    );
  }

  @override
  MovieDashboardVm createModel() {
    return ref.read(movieDashboardProvider);
  }
}

class MovieList extends ConsumerWidget {
  const MovieList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("Child Rebuild...");

    final List<Movie> movieService = ref.watch(movieProvider);
    return ListView.builder(
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
    );
  }
}
