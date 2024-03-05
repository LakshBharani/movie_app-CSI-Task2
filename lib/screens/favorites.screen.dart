import 'package:flutter/material.dart';
import 'package:movie_app/components/header.dart';
import 'package:movie_app/constants/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: const SafeArea(
        child: Column(
          children: [
            Header(
              title: "Favorites",
              onlyTitleShown: true,
            ),
          ],
        ),
      ),
    );
  }
}
