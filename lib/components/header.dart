import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.title,
    this.onlyTitleShown = false,
  });

  final String title;
  final bool onlyTitleShown;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      leading: !onlyTitleShown
          ? const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.movie, size: 24, color: Colors.white),
            )
          : null,
      actions: !onlyTitleShown
          ? [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, size: 24, color: Colors.white),
              )
            ]
          : null,
      title: Text(title,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center),
    );
  }
}
