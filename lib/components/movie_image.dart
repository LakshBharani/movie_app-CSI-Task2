import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';

class MovieImageWdget extends StatelessWidget {
  const MovieImageWdget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 300,
      child: Stack(children: <Widget>[
        Image.network(
          // '${ApiConfig.imageBaseUrl}${movies[0].backDropPath}',
          'https://image.tmdb.org/t/p/w500/8Y43POKjjKDGI9MH89NW0NAzzp8.jpg',
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: bgColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Color.fromARGB(190, 255, 255, 255),
              size: 50,
            ),
          ),
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
                colors: <Color>[bgColor, bgColor.withOpacity(0.0)],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
