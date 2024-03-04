import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/models/movie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
        margin: const EdgeInsets.only(top: 20, bottom: 60),
        height: 300,
        child: Hero(
          tag: 'movieBanner',
          child: Stack(children: <Widget>[
            CachedNetworkImage(
              imageUrl:
                  '${ApiConfig.imageBaseUrl}${movies[index].backDropPath}',
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
                    end: const Alignment(0.0, 0.8),
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
                    begin: const Alignment(0.0, 0.8),
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
      ),
      Positioned(
        bottom: 8,
        left: 0,
        right: 0,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: AutoSizeText(
                movies[index].title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: RatingBarIndicator(
                rating: movies[index].voteAverage / 2,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 18.0,
              ),
            ),
            Hero(
              tag: 'movieInfoRow',
              child: Material(
                type: MaterialType.transparency,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: descTextColor, width: 2),
                      ),
                      child: Text(
                        movies[index].adult ? 'R' : 'PG-13',
                        style: TextStyle(
                            fontSize: 10,
                            color: descTextColor,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: descTextColor, width: 2),
                          color: descTextColor),
                      child: Text(
                        movies[index].releaseDate,
                        style: TextStyle(
                            fontSize: 10,
                            color: bgColor,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
