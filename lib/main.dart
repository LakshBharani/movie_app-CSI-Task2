import 'package:flutter/material.dart';
import 'package:movie_app/screens/home.screen.dart';

import 'screens/movie.info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Movie Catalogue',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/movie-info': (context) => const MovieInfoScreen(),
        });
  }
}
