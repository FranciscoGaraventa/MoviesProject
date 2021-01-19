import '../models/genre_model.dart';
import '../models/item_model.dart';

abstract class IMovieRepository {
  Future<ItemModel> fetchTrendingMovies();

  Future<ItemModel> fetchMovieByGenre(String genreId);

  Future<ItemModel> fetchMoviesBySearch(String query);

  Future<GenreModel> fetchAllGenres();
}
