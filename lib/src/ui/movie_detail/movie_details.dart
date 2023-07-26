import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetails extends ConsumerStatefulWidget {
  final String overview;
  final String backdropPath;
  final String releaseDate;
  final String originalLanguage;
  final String originalTitle;

  const MovieDetails({
    super.key,
    required this.overview,
    required this.backdropPath,
    required this.releaseDate,
    required this.originalLanguage,
    required this.originalTitle,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends ConsumerState<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          centerTitle: true,
          backgroundColor: Colors.black87,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(widget.originalTitle),
            ),
            titlePadding:
                const EdgeInsetsDirectional.only(start: 60, bottom: 15),
            centerTitle: true,
            background: Image.network(
              widget.backdropPath,
              fit: BoxFit.fill,
              width: double.maxFinite,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/png/no_img_found.png',
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                );
              },
            ),
          ),
          expandedHeight: 230,
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
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
          ),
        ),
        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     (context, index) => ListTile(
        //       tileColor: (index % 2 == 0) ? Colors.white : Colors.green[50],
        //       title: Center(
        //         child: Text('$index',
        //             style: const TextStyle(
        //                 fontWeight: FontWeight.normal,
        //                 fontSize: 50,
        //                 color: Colors.black45)),
        //       ),
        //     ),
        //     childCount: 21,
        //   ),
        // )
      ],
    ));
  }
}
