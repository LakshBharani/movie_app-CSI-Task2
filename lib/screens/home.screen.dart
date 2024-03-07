import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/header.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/navigate.moreInfo.dart';
import 'package:movie_app/screens/favorites.screen.dart';

import '../api_config.dart';
import '../components/movie.display.banner.dart';
import '../models/movie.dart';
import '../movie_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key})
      : super(key: key); // Corrected super constructor invocation

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies(); // Fetch movies when the screen initializes
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

  int screenIndex = 0;
  List<MaterialColor> colors = [
    Colors.blue,
    Colors.red,
    Colors.grey,
    Colors.green,
    Colors.deepOrange,
    Colors.yellow,
    Colors.blue,
    Colors.brown,
    Colors.pink,
    Colors.green,
    Colors.pink,
    Colors.brown,
    Colors.yellow,
    Colors.deepPurple,
    Colors.brown,
    Colors.deepPurple,
    Colors.grey,
    Colors.red,
    Colors.pink,
    Colors.green,
  ];

  void _onItemTapped(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
            gradient: screenIndex == 0
                ? LinearGradient(
                    colors: [
                      bgColor.withOpacity(0.6),
                      bgColor,
                      colors[index].withOpacity(0.2),
                    ], // Adjust colors as needed
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.1, 0.5, 1.0],
                    tileMode: TileMode.clamp,
                  )
                : null,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            bottomSheet: Container(
              color: bgColor,
              padding: const EdgeInsets.only(bottom: 20),
              child: BottomNavigationBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                unselectedItemColor: Colors.white70,
                selectedItemColor: Colors.amber,
                currentIndex: screenIndex,
                onTap: (index) => _onItemTapped(index),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorites',
                  ),
                ],
              ),
            ),
            body: screenIndex == 0
                ? SafeArea(
                    child: movies.isNotEmpty
                        ? Column(
                            children: [
                              // Header
                              const Header(
                                title: "Movies",
                                onlyTitleShown: false,
                              ),
                              // Movie Background Image
                              MovieBackgroundImage(
                                  movies: movies, index: index),
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
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.scale,
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
                                            navigateToMoreInfo(
                                                context, movie, movies, index);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 1.0),
                                            color: Colors.transparent,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              child: CachedNetworkImage(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                imageUrl:
                                                    '${ApiConfig.imageBaseUrl}${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator(
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
                  )
                : FavoritesScreen(movies: movies),
          ),
        ));
  }
}
