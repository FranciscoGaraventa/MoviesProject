import '../models/genre_model.dart';
import '../models/movie_model.dart';

abstract class IMovieRepository {
  Future<MovieModel> fetchTrendingMovies();

  Future<MovieModel> fetchMovieByGenre(String genreId);

  Future<MovieModel> fetchMoviesBySearch(String query);

  Future<GenreModel> fetchAllGenres();
}
