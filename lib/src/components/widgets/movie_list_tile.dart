import 'package:flutter/material.dart';
import 'package:movie_app/src/components/widgets/movie_title_widget.dart';
import 'package:movie_app/src/models/movie.dart';

class MovieListTile extends StatelessWidget {
  final Movie movie;

  const MovieListTile({Key? key, required this.movie}) : super(key: key);

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
            child: MovieTitleWidget(text: movie.title),
          ),
        ],
      ),
    );
  }
}
