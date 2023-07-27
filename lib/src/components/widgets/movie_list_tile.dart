// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:movie_app/src/models/movie.dart';

class MovieListTile extends StatelessWidget {
  final Movie movie;
  const MovieListTile({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Row(
        children: [
          (movie.imagePath != null)
              ? Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.36,
                    height: MediaQuery.of(context).size.height * 0.28,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: FileImage(movie.imagePath ?? File('')),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : Flexible(
                  child: Hero(
                    tag: 'movieCard1',
                    transitionOnUserGestures: true,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        movie.fullImageUrl,
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
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Text(
                        movie.title,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      movie.overview,
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
    );
  }
}
