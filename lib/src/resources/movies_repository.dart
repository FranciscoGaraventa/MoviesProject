import '../models/genre_model.dart';
import '../models/movie_model.dart';
import 'movie_api_provider.dart';
import 'movie_repository_interface.dart';

class MoviesRepository implements IMovieRepository {
  final moviesApiProvider = MovieApiProvider();

  @override
  Future<MovieModel> fetchTrendingMovies() => moviesApiProvider.fetchTrendingMovies();

  @override
  Future<GenreModel> fetchAllGenres() => moviesApiProvider.fetchGenreList();

  @override
  Future<MovieModel> fetchMovieByGenre(genre) => moviesApiProvider.fetchMovieByGenre(genre);

  @override
  Future<MovieModel> fetchMoviesBySearch(query) => moviesApiProvider.fetchMoviesBySearch(query);
}
