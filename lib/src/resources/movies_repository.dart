import '../models/genre_model.dart';
import '../models/item_model.dart';
import 'movie_api_provider.dart';
import 'movie_repository_interface.dart';

class MoviesRepository implements IMovieRepository {
  final moviesApiProvider = MovieApiProvider();

  @override
  Future<ItemModel> fetchTrendingMovies() => moviesApiProvider.fetchMovieList();

  @override
  Future<GenreModel> fetchAllGenres() => moviesApiProvider.fetchGenreList();

  @override
  Future<ItemModel> fetchMovieByGenre(genre) => moviesApiProvider.fetchMovieByGenre(genre);

  @override
  Future<ItemModel> fetchMoviesBySearch(query) => moviesApiProvider.fetchMoviesBySearch(query);
}
