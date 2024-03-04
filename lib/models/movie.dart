class Movie {
  final int id;
  final String title;
  final String releaseDate;
  final String originalLanguage;
  final String overview;
  final String posterPath;
  final String backDropPath;
  final double voteAverage;
  final bool adult;

  Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.originalLanguage,
    required this.overview,
    required this.posterPath,
    required this.backDropPath,
    required this.voteAverage,
    required this.adult,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    print(json);
    return Movie(
      id: json['id'],
      adult: json['adult'],
      title: json['title'],
      releaseDate: json['release_date'],
      originalLanguage: json['original_language'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backDropPath: json['backdrop_path'],
      voteAverage: json['vote_average'].toDouble(),
    );
  }
}
