import '../data/mock_movie.dart';
import '../model/movie.dart';

class MovieService {
  List<Movie> getFavoriteMovies() {
    return mockMovies;
  }
}
