import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/movie.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  final bool autofocus;
  final VoidCallback onSelect;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onSelect,
    this.autofocus = false,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final hasPoster = widget.movie.posterUrl != null && widget.movie.posterUrl!.isNotEmpty;

    return Focus(
      autofocus: widget.autofocus,
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            (event.logicalKey == LogicalKeyboardKey.select ||
             event.logicalKey == LogicalKeyboardKey.enter ||
             event.logicalKey == LogicalKeyboardKey.gameButtonA)) {
          widget.onSelect();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isFocused = true),
        onExit: (_) => setState(() => _isFocused = false),
        child: GestureDetector(
          onTap: widget.onSelect,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isFocused ? const Color(0xFFC084FC) : Colors.transparent,
                width: 3,
              ),
              boxShadow: _isFocused
                  ? [
                      BoxShadow(
                        color: const Color(0x99A855F7),
                        blurRadius: 16,
                        spreadRadius: 2,
                      )
                    ]
                  : [],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image or Purple Placeholder
                  if (hasPoster)
                    Image.network(
                      widget.movie.posterUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _buildPurplePlaceholder(),
                    )
                  else
                    _buildPurplePlaceholder(),

                  // Bottom Gradient for Text Legibility
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 60,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Color(0xF2000000),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Rating Badge (Top Left)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xA6000000),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFBBF24),
                            size: 13,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            widget.movie.rating % 1 == 0
                                ? widget.movie.rating.toInt().toString()
                                : widget.movie.rating.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // "VER" Badge (Top Right when Focused)
                  if (_isFocused)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA855F7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 12,
                            ),
                            SizedBox(width: 2),
                            Text(
                              'VER',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Movie Title (Bottom Center)
                  Positioned(
                    bottom: 10,
                    left: 8,
                    right: 8,
                    child: Text(
                      widget.movie.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPurplePlaceholder() {
    return Container(
      color: const Color(0xFF4C1D95),
      child: const Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Color(0xFFA78BFA),
          size: 40,
        ),
      ),
    );
  }
}
