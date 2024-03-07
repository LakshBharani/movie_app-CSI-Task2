import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';

import '../api_config.dart';
import '../models/movie.dart';
import '../movie_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

// Variable to store the searched movie name
String movieNameSearched = "";

class _SearchScreenState extends State<SearchScreen> {
  List<Movie> movies = [];
  List<Movie> filteredMovies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies(); // Fetch movies when the screen initializes
  }

  // Function to fetch movies from the API
  Future<void> fetchMovies() async {
    try {
      final List<Movie> fetchedMovies = await MovieService.fetchMovies();
      setState(() {
        movies = fetchedMovies;
        filteredMovies = movies; // Initially set filteredMovies to all movies
      });
    } catch (e) {
      print('Error fetching movies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: TextFormField(
            onChanged: (value) => {
              setState(() {
                movieNameSearched = value; // Update search query
              }),
              // Filter movies based on search query
              filteredMovies = movies
                  .where((movie) => movie.title
                      .toLowerCase()
                      .contains(movieNameSearched.toLowerCase()))
                  .toList(),
            },
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              hintText: 'Search for movies',
              hintStyle: TextStyle(color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: movies.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Display "Popular Searches" if no search query
                  movieNameSearched == ""
                      ? const Text(
                          'Popular Searches',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: filteredMovies.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '${ApiConfig.imageBaseUrl}${filteredMovies[index].posterPath}',
                                      placeholder: (context, url) {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
