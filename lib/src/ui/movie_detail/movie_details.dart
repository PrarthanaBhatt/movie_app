import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetails extends ConsumerStatefulWidget {
  final String originalTitle;
  final String overview;
  const MovieDetails({
    super.key,
    required this.originalTitle,
    required this.overview,
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
        body: Text(widget.originalTitle));
  }
}
