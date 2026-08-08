import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../model/movie.dart';
import '../services/movie_service.dart';
import 'sliver_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieService _movieService = MovieService();
  late List<Movie> _movies;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  void _loadMovies() {
    setState(() {
      _movies = _movieService.getFavoriteMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0C),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Top App Bar / Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 8),
                child: FadeInDown(
                  duration: const Duration(milliseconds: 400),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Text(
                            '❤️',
                            style: TextStyle(fontSize: 22),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Mis Películas Favoritas',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.refresh_rounded,
                          color: Colors.white70,
                          size: 24,
                        ),
                        onPressed: _loadMovies,
                        tooltip: 'Recargar',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Movie Grid via SliverGrid
            MovieSliverGrid(
              movies: _movies,
              onMovieSelect: (movie) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Reproduciendo: ${movie.title}'),
                    duration: const Duration(seconds: 2),
                    backgroundColor: const Color(0xFFA855F7),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
