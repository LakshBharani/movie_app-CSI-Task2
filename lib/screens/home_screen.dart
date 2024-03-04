import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/header.dart';
import 'package:movie_app/constants/colors.dart';

import '../api_config.dart';
import '../components/movieBackgroundImage.dart';
import '../models/movie.dart';
import '../movie_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [];
  int index = 0;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final List<Movie> fetchedMovies = await MovieService.fetchMovies();
      setState(() {
        movies = fetchedMovies;
      });
    } catch (e) {
      print('Error fetching movies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: movies.isNotEmpty
            ? Column(
                children: [
                  // Header
                  const Header(),
                  // Movie Background Image
                  MovieBackgroundImage(movies: movies, index: index),
                  // Movie info
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          movies[index].voteAverage.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Carousel Slider
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 0.4,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      onPageChanged: (index, reason) {
                        setState(() {
                          this.index = index;
                        });
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: bgColor.withOpacity(1),
                                borderRadius: BorderRadius.circular(
                                    5.0), // Rounded border
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${ApiConfig.imageBaseUrl}${movie.posterPath}',
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
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
