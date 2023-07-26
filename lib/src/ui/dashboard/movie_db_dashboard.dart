import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/components/base/base_consumer_state.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/providers/view_model_providers.dart';
import 'package:movie_app/src/routes/routes.dart';
import 'package:movie_app/src/ui/add_movie/add_movie.dart';
import 'package:movie_app/src/ui/dashboard/movie_dashboard_vm.dart';
import 'package:movie_app/src/ui/dashboard_provider/dashboard_provider_notifier.dart';
import 'package:movie_app/src/utils/constant.dart';
import 'package:movie_app/src/utils/helpers/movie_sql_helper.dart';
import 'package:movie_app/src/utils/internet_connectivity.dart';

import '../../constants/sharedpref_value.dart';

class MovieDBDashboardScreen extends ConsumerStatefulWidget {
  const MovieDBDashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardConsumerState();
}

class _DashboardConsumerState
    extends BaseConsumerState<MovieDBDashboardScreen, MovieDashboardVm> {
  List<Map<String, dynamic>> _movieDbList = [];

  void checkInternet() async {
    bool isConnected = await checkInternetConnectivity();
    if (isConnected) {
      print('Internet is available.');
      final List<Movie> movieService = ref.watch(movieProvider);
    } else {
      print('No internet connection.');
    }
  }

  void _refreshMovieList() async {
    final data = await MovieSQLHelper.getItems();
    setState(() {
      _movieDbList = data;
    });
  }

  @override
  void initState() {
    super.initState();
    checkInternet();
    _refreshMovieList();

    print("...number of items ${_movieDbList.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie ${_movieDbList.length}"),
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
                    _refreshMovieList();
                  }
                },
                child: const Icon(Icons.add)),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
                onTap: () async {
                  SharedPrefValue.setPrefValue(isLoggedIn, false);
                  context.go(Routes.loginScreen);
                },
                child: const Icon(Icons.logout_outlined)),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        itemCount: _movieDbList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final Map<String, dynamic> movie = _movieDbList[index];

          return GestureDetector(
            onTap: () {
              context.pushNamed(
                Routes.movieDetails,
                pathParameters: {
                  "overview": movie['overview'],
                  "backdropPath": movie['backdropPath'],
                  "releaseDate": movie['releaseDate'],
                  "originalLanguage": movie['originalLanguage'],
                  "originalTitle": movie['originalTitle'],
                },
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Row(
                children: [
                  Flexible(
                    child: Hero(
                      tag: 'movieCard1',
                      transitionOnUserGestures: true,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          movie['posterPath'],
                          fit: BoxFit.cover,
                          width: 130,
                          errorBuilder: (context, error, stackTrace) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/png/no_img_found.png',
                                    fit: BoxFit.cover,
                                    width: 130,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Column(
                      children: [
                        Flexible(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 8.0),
                              child: Text(
                                movie['title'],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              movie['overview'],
                              style: const TextStyle(fontSize: 12),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(
                                Icons.favorite,
                                color: Colors.black45,
                              ),
                              Icon(
                                Icons.add_circle_outline,
                                color: Colors.black45,
                              ),
                              Icon(
                                Icons.remove_circle_outline,
                                color: Colors.black45,
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
      ),
    );
  }

  @override
  MovieDashboardVm createModel() {
    return ref.read(movieDashboardProvider);
  }
}
