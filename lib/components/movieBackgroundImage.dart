import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/models/movie.dart';

import '../api_config.dart';

class MovieBackgroundImage extends StatelessWidget {
  const MovieBackgroundImage({
    super.key,
    required this.movies,
    required this.index,
  });

  final List<Movie> movies;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(top: 20),
        height: 300,
        child: Stack(children: <Widget>[
          CachedNetworkImage(
            imageUrl: '${ApiConfig.imageBaseUrl}${movies[index].backDropPath}',
            placeholder: (context, url) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            },
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: const Alignment(0.0, 0.4),
                  begin: const Alignment(0.0, -1),
                  colors: <Color>[bgColor, bgColor.withOpacity(0.0)],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: const Alignment(0.0, -1),
                  begin: const Alignment(0.0, 0.4),
                  colors: <Color>[
                    bgColor,
                    bgColor.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 25,
              ),
              child: Text(
                movies[index].title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
