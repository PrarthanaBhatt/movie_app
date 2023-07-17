import 'package:flutter/material.dart';
import 'package:movie_app/src/models/movie.dart';

class MovieListTile extends StatelessWidget {
  final Movie movie;

  const MovieListTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                movie.fullImageUrl,
                fit: BoxFit.cover,
                width: 80,
              ),
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
                      movie.title,
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
    );
  }
}
