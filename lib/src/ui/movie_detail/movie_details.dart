import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetails extends ConsumerStatefulWidget {
  final String overview;
  final String backdropPath;
  final String releaseDate;
  final String originalLanguage;
  // final String voteAverage;
  final String originalTitle;

  const MovieDetails({
    super.key,
    required this.overview,
    required this.backdropPath,
    required this.releaseDate,
    required this.originalLanguage,
    // required this.voteAverage,
    required this.originalTitle,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends ConsumerState<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Movie Details"),
          backgroundColor: Colors.black45,
        ),
        body: Column(
          children: [
            Image.network(
              widget.backdropPath,
              fit: BoxFit.fill,
              width: double.maxFinite,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.originalTitle,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Language: ${widget.originalLanguage}"),
                        Text("Release On:${widget.releaseDate}"),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Overview:",
                          style: TextStyle(fontSize: 14),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.overview,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
