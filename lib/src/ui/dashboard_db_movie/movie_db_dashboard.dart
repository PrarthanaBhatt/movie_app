import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/components/base/base_consumer_state.dart';
import 'package:movie_app/src/components/widgets/shimmer_widget.dart';
import 'package:movie_app/src/components/widgets/text_details_shimmer.dart';
import 'package:movie_app/src/constants/sharedpref_value.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/providers/view_model_providers.dart';
import 'package:movie_app/src/routes/routes.dart';
import 'package:movie_app/src/ui/add_movie/add_movie.dart';
import 'package:movie_app/src/ui/dashboard/movie_dashboard_vm.dart';
import 'package:movie_app/src/ui/dashboard_provider/dashboard_provider_notifier.dart';
import 'package:movie_app/src/utils/constant.dart';
import 'package:movie_app/src/utils/helpers/movie_sql_helper.dart';
import 'package:movie_app/src/utils/internet_connectivity.dart';
import 'package:shimmer/shimmer.dart';

class MovieDBDashboardScreen extends ConsumerStatefulWidget {
  const MovieDBDashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardConsumerState();
}

class _DashboardConsumerState
    extends BaseConsumerState<MovieDBDashboardScreen, MovieDashboardVm> {
  bool isLoading = false;
  List<Map<String, dynamic>> _movieDbList = [];
  bool isConnected = false;
  List<Movie> movieService = [];

  void checkInternet() async {
    isConnected = await checkInternetConnectivity();
    if (isConnected) {
      movieService = await ref.watch(movieProvider);
      // const delayDuration = Duration(seconds: 2);
      // await Future.delayed(delayDuration);
      _refreshMovieList();
      print('Internet is available.');
    } else {
      _refreshMovieList();
      print('No internet connection.');
    }
  }

  void _refreshMovieList() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2), () {});
    final data = await MovieSQLHelper.getItems();
    setState(() {
      _movieDbList = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    checkInternet();

    print("...number of items ${_movieDbList.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF28282B),
      appBar: AppBar(
        title: Text("Movie ${_movieDbList.length}"),
        backgroundColor: Colors.black45,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
                onTap: () {
                  _refreshMovieList();
                },
                child: const Icon(Icons.refresh)),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
                onTap: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddMovie()),
                  );

                  if (result != null) {
                    // ref.read(movieProvider.notifier).add(result);

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
        itemCount: isLoading ? 10 : _movieDbList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (isLoading) {
            // return buildShimmer(context);
            return loadingShimmer(context);
          } else {
            final Map<String, dynamic> movie = _movieDbList[index];

            return GestureDetector(
              onTap: () {
                (movie['originalTitle'] != "")
                    ? context.pushNamed(
                        Routes.movieDetails,
                        pathParameters: {
                          "overview": movie['overview'],
                          "backdropPath": movie['backdropPath'],
                          "releaseDate": movie['releaseDate'],
                          "originalLanguage": movie['originalLanguage'],
                          "originalTitle": movie['originalTitle'],
                        },
                      )
                    : ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No Data Found')),
                      );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                elevation: 0,
                // color: Theme.of(context).colorScheme.surfaceVariant,
                color: const Color(0xFFF1F1F1),
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
                                  style: const TextStyle(
                                    color: Color(0xFF28282B),
                                    fontFamily: 'OpenSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                movie['overview'],
                                style: const TextStyle(
                                  color: Color(0xFF28282B),
                                  fontFamily: 'OpenSans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, top: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Icon(
                                  Icons.favorite,
                                  color: Color(0xFF114084),
                                ),
                                Icon(
                                  Icons.add_circle_outline,
                                  color: Color(0xFF114084),
                                ),
                                Icon(
                                  Icons.remove_circle_outline,
                                  color: Color(0xFF114084),
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
          }
        },
      ),
    );
  }

  @override
  MovieDashboardVm createModel() {
    return ref.read(movieDashboardProvider);
  }
}

Widget buildShimmer(context) => ListTile(
    leading: ShimmerWidget.circular(
      width: 125,
      height: 185,
      shapeBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    title: Align(
        alignment: Alignment.centerLeft,
        child: ShimmerWidget.rectagular(
            width: MediaQuery.of(context).size.width * 0.3, height: 16)),
    subtitle: const ShimmerWidget.rectagular(height: 12));

Widget loadingShimmer(context) => Shimmer.fromColors(
    baseColor: Colors.grey.shade400,
    highlightColor: Colors.grey.shade300,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Column(
              children: const [
                TextDetailsShimmer(),
                SizedBox(
                  height: 8,
                ),
                TextDetailsShimmer(),
                SizedBox(
                  height: 8,
                ),
                TextDetailsShimmer(),
              ],
            ),
          ),
        ],
      ),
    ));
