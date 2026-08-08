class Movie {
  final String id;
  final String title;
  final double rating;
  final String? posterUrl;

  const Movie({
    required this.id,
    required this.title,
    required this.rating,
    this.posterUrl,
  });
}
