import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../api_config.dart';

class CachedMovieBanner extends StatelessWidget {
  const CachedMovieBanner({
    super.key,
    required this.movie,
    required this.color,
  });

  final Map movie;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: 300,
        child: Stack(children: <Widget>[
          CachedNetworkImage(
            imageUrl: '${ApiConfig.imageBaseUrl}${movie['backDropPath']}',
            placeholder: (context, url) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            },
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
        ]),
      )
    ]);
  }
}
