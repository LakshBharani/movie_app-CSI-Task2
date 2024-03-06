import 'package:flutter/material.dart';

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
      backgroundColor: Colors.transparent,
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
                onPressed: () {
                  Navigator.pushNamed(context, 'search');
                },
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
