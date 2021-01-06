import '../models/genre_model.dart';
import '../models/item_model.dart';

abstract class IMovieRepository {
  Future<ItemModel> fetchTrendingMovies();
  Future<GenreModel> fetchAllGenres();
}
