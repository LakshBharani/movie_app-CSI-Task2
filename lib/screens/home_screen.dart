import 'package:flutter/material.dart';
import 'package:movie_app/components/header.dart';
import 'package:movie_app/components/movie_carousel.dart';
import 'package:movie_app/components/movie_image.dart';
import 'package:movie_app/constants/colors.dart';

import '../models/movie.dart';
import '../movie_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [];

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
        child: Column(
          children: [
            const Header(),
            const MovieImageWdget(),
            MovieCarousel(movies: movies),
          ],
        ),
      ),
    );
  }
}
