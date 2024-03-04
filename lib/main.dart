import 'package:flutter/material.dart';
import 'package:movie_app/provider/current_movie_index.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieIndexProvider>(
      create: (BuildContext context) => MovieIndexProvider(),
      child: MaterialApp(
        title: 'Movie Catalogue',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
