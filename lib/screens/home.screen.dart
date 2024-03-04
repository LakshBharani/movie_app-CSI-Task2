import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/header.dart';
import 'package:movie_app/constants/colors.dart';

import '../api_config.dart';
import '../components/movie.display.banner.dart';
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
                  // Carousel Slider
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 0.4,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        pauseAutoPlayOnManualNavigate: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        pauseAutoPlayOnTouch: true,
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
                                Navigator.pushNamed(context, '/movie-info',
                                    arguments: {
                                      'allMovies': movies,
                                      'title': movie.title,
                                      'backDropPath': movie.backDropPath,
                                      'overview': movie.overview,
                                      'releaseDate': movie.releaseDate,
                                      'voteAverage': movie.voteAverage,
                                      'adult': movie.adult,
                                      'originalLanguage':
                                          movie.originalLanguage,
                                      'posterPath': movie.posterPath,
                                      'id': movie.id,
                                      'index': index,
                                    });
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                color: bgColor,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    imageUrl:
                                        '${ApiConfig.imageBaseUrl}${movie.posterPath}',
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
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
