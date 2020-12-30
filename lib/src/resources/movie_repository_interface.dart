import '../models/item_model.dart';

abstract class IMovieRepository {
  Future<ItemModel> fetchTrendingMovies();
}
