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
import 'package:movie_app/src/utils/helpers/movie_sql_helper.dart';

class MovieDBDashboardScreen extends ConsumerStatefulWidget {
  const MovieDBDashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardConsumerState();
}

class _DashboardConsumerState
    extends BaseConsumerState<MovieDBDashboardScreen, MovieDashboardVm> {
  @override
  Widget build(BuildContext context) {
    print("Parent Rebuild...");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard DB"),
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

class MovieList extends ConsumerStatefulWidget {
  const MovieList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieListState();
}

class _MovieListState extends ConsumerState<MovieList> {
  List<Map<String, dynamic>> _movieDbList = [];

  void _refreshMovieList() async {
    final data = await MovieSQLHelper.getItems();
    setState(() {
      _movieDbList = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshMovieList();

    // _addItem();
    print("...number of items ${_movieDbList.length}");
  }

  Future<void> _addItem() async {
    final List<Movie> movieService = ref.watch(movieProvider);

    // await MovieSQLHelper.createItem(
    //     movieService.title, movieService.posterPath);
    _refreshMovieList();
    print("...number of items ${_movieDbList.length}");
  }

  @override
  Widget build(BuildContext context) {
    print("...Child Rebuild...");

    final List<Movie> movieService = ref.watch(movieProvider);
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      // itemCount: movieService.length,
      itemCount: _movieDbList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        // final Movie movie = movieService[index];
        final Map<String, dynamic> movie = _movieDbList[index];

        return GestureDetector(
          onTap: () {
            // context.pushNamed(
            //   Routes.movieDetails,
            //   pathParameters: {
            //     "overview": movie.overview,
            //     "backdropPath": movie.fullBannerImageUrl,
            //     "releaseDate": movie.releaseDate,
            //     "originalLanguage": movie.originalLanguage,
            //     "originalTitle": movie.originalTitle
            //   },
            // );
          },
          // child: Text(_movieDbList[index]['title'].toString()),
          child: Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Row(
              children: [
                (movie['posterPath'] != null)
                    ? Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.network(
                            movie['posterPath'],
                            fit: BoxFit.cover,
                            width: 80,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          'assets/png/no_img_found.png',
                          fit: BoxFit.cover,
                          width: 80,
                        ),
                      ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Column(
                    children: [
                      Flexible(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            movie['title'],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.black45,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.add_circle_outline,
                                color: Colors.black45,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.remove_circle_outline,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
