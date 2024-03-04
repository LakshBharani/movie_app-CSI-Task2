import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/provider/current_movie_index.dart';
import '../api_config.dart';

class MovieCarousel extends StatelessWidget {
  final List<Movie> movies;

  const MovieCarousel({super.key, required this.movies});
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 0.4,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        onPageChanged: (index, reason) {
          MovieIndexProvider movieIndexProvider = MovieIndexProvider();
          movieIndexProvider.setCurrentIndex(index);
        },
      ),
      items: movies.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                print(
                  '${ApiConfig.imageBaseUrl}${movie.posterPath}',
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: bgColor.withOpacity(1),
                  borderRadius: BorderRadius.circular(5.0), // Rounded border
                ),
                child: CachedNetworkImage(
                  imageUrl: '${ApiConfig.imageBaseUrl}${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
