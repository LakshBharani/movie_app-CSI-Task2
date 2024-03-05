import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';

import '../api_config.dart';
import '../components/cached.movie.banner.dart';
import '../models/dbhelper.dart';

class MovieInfoScreen extends StatefulWidget {
  const MovieInfoScreen({super.key});

  @override
  State<MovieInfoScreen> createState() => _MovieInfoScreenState();
}

bool isFav = false;
DatabaseHelper dbHelper = DatabaseHelper();

class _MovieInfoScreenState extends State<MovieInfoScreen> {
  void checkFavorite() async {
    final movie = ModalRoute.of(context)!.settings.arguments as Map;
    List<Map<String, dynamic>> favorites = await dbHelper.getFavoriteMovies();
    setState(() {
      isFav = favorites.any((fav) => fav['id'] == movie['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    checkFavorite();

    final movie = ModalRoute.of(context)!.settings.arguments as Map;

    Map<String, dynamic> movieData = {
      "id": movie['id'],
      "title": movie['title'],
      "year": movie['releaseDate'],
    };

    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText(
            movie['title'],
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            maxLines: 1,
          ),
          backgroundColor: bgColor,
          elevation: 0,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () async {
                isFav
                    ? await dbHelper.deleteMovie(movie['id'])
                    : await dbHelper.saveMovie(movieData);
                List<Map<String, dynamic>> favorites =
                    await dbHelper.getFavoriteMovies();
                print(favorites);
                setState(() {
                  isFav = !isFav;
                });
              },
              icon: !isFav
                  ? const Icon(Icons.favorite_outline)
                  : const Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    ),
            ),
          ],
        ),
        backgroundColor: bgColor,
        body: ListView(
          children: [
            Card(
              color: Colors.transparent,
              margin: EdgeInsets.zero,
              elevation: isFav ? 80 : 0,
              shadowColor: isFav ? Colors.redAccent : null,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Hero(
                tag: 'movieBanner',
                child: CachedMovieBanner(
                  movie: movie,
                  color: isFav ? Colors.redAccent : bgColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Card(
                color: bgColor,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
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
                                  border: Border.all(
                                      color: descTextColor, width: 2),
                                ),
                                child: Text(
                                  movie['adult'] ? 'R' : 'PG-13',
                                  style: TextStyle(
                                      fontSize: 12,
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
                                    border: Border.all(
                                        color: descTextColor, width: 2),
                                    color: descTextColor),
                                child: Text(
                                  movie['releaseDate'],
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: bgColor,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.language,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      movie['originalLanguage'],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                      movie['voteAverage'].toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: ListTile(
                title: const Text(
                  "About",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
                subtitle: Text(
                  movie['overview'],
                  style: TextStyle(fontSize: 14, color: descTextColor),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width * 0.4,
                  imageUrl: '${ApiConfig.imageBaseUrl}${movie['posterPath']}',
                  placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
