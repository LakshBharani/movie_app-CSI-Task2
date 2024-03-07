// Importing necessary packages and files
import 'package:flutter/material.dart';
import 'package:movie_app/screens/home.screen.dart';
import 'package:movie_app/screens/search.movies.screen.dart';

import 'screens/movie.info.dart';

// Main function to run the app
Future<void> main() async {
  // Ensuring that the Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Running the app
  runApp(const MyApp());
}

// MyApp class, which is the root widget of the application
class MyApp extends StatelessWidget {
  // Constructor for MyApp
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp widget, which sets up the basic configuration of the app
    return MaterialApp(
        // Title of the app
        title: 'Movie Catalogue',
        // Setting debug banner to false
        debugShowCheckedModeBanner: false,
        // Theme configuration for the app
        theme: ThemeData(
          // Using Material 3 design
          useMaterial3: true,
        ),
        // Initial route when the app starts
        initialRoute: '/',
        // Define routes for different screens
        routes: {
          // Home screen route
          '/': (context) => const HomeScreen(),
          // Movie info screen route
          '/movie-info': (context) => const MovieInfoScreen(),
          // Search screen route
          'search': (context) => const SearchScreen(),
        });
  }
}
