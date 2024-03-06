import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';

import '../api_config.dart';
import '../components/header.dart';
import '../constants/navigate.moreInfo.dart';
import '../models/dbhelper.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key, required this.movies});
  final movies;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              bgColor.withOpacity(0.6),
              bgColor,
              Colors.redAccent.withOpacity(0.2),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.2, 0.3, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                const Header(
                  title: "Favorites",
                  onlyTitleShown: true,
                ),
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: DatabaseHelper().getFavoriteMovies(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error loading data'));
                      } else {
                        final favoriteMovies = snapshot.data ?? [];
                        final filteredMovies = movies.where((movie) {
                          return favoriteMovies
                              .any((favMovie) => favMovie['id'] == movie.id);
                        }).toList();

                        if (filteredMovies.isEmpty) {
                          return const Center(
                            child: Text(
                              'No favorite movies yet!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          );
                        }

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: filteredMovies.length,
                          itemBuilder: (BuildContext context, int index) {
                            final movie = filteredMovies[index];
                            return GestureDetector(
                              onTap: () {
                                navigateToMoreInfo(
                                    context, movie, movies, index);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '${ApiConfig.imageBaseUrl}${movie.posterPath}',
                                          placeholder: (context, url) {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
