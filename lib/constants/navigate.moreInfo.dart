import 'package:flutter/material.dart';

import '../models/movie.dart';

void navigateToMoreInfo(
    BuildContext context, Movie movie, List<Movie> movies, int index) {
  Navigator.pushNamed(context, '/movie-info', arguments: {
    'allMovies': movies,
    'title': movie.title,
    'backDropPath': movie.backDropPath,
    'overview': movie.overview,
    'releaseDate': movie.releaseDate,
    'voteAverage': movie.voteAverage,
    'adult': movie.adult,
    'originalLanguage': movie.originalLanguage,
    'posterPath': movie.posterPath,
    'id': movie.id,
    'index': index,
  });
}
