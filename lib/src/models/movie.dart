import 'dart:convert';
import 'dart:io';

class Movie {
  String title;
  String posterPath;
  String overview;
  String backdropPath;
  String releaseDate;
  String originalLanguage;
  String originalTitle;
  File? imagePath;

  Movie(
      {required this.title,
      required this.posterPath,
      required this.overview,
      required this.backdropPath,
      required this.releaseDate,
      required this.originalLanguage,
      required this.originalTitle,
      this.imagePath});

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$posterPath';
  String get fullBannerImageUrl =>
      'https://image.tmdb.org/t/p/w200$backdropPath';

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'poster_path': posterPath,
      'overview': overview,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'original_language': originalLanguage,
      'original_title': originalTitle,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'],
      posterPath: map['poster_path'],
      overview: map['overview'],
      backdropPath: map['backdrop_path'],
      releaseDate: map['release_date'],
      originalLanguage: map['original_language'],
      originalTitle: map['original_title'],
    );
  }

  String toJson() => json.encode(toMap());
  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
