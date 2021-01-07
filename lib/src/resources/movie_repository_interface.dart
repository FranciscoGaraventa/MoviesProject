import '../models/genre_model.dart';
import '../models/item_model.dart';

abstract class IMovieRepository {
  Future<ItemModel> fetchTrendingMovies();
  Future<ItemModel> fetchMovieByGenre(int genreId);
  Future<GenreModel> fetchAllGenres();
}
