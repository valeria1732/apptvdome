import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../model/movie.dart';
import '../witgets/movie_card.dart';

class MovieSliverGrid extends StatelessWidget {
  final List<Movie> movies;
  final Function(Movie) onMovieSelect;

  const MovieSliverGrid({
    super.key,
    required this.movies,
    required this.onMovieSelect,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 4;
    if (screenWidth < 600) {
      crossAxisCount = 2;
    } else if (screenWidth < 900) {
      crossAxisCount = 3;
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final movie = movies[index];
            return FadeInUp(
              duration: Duration(milliseconds: 300 + (index * 60)),
              child: MovieCard(
                movie: movie,
                autofocus: index == 0,
                onSelect: () => onMovieSelect(movie),
              ),
            );
          },
          childCount: movies.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.72,
        ),
      ),
    );
  }
}
