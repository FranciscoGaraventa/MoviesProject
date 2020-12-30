import '../models/item_model.dart';
import 'movie_api_provider.dart';
import 'movie_repository_interface.dart';

class MoviesRepository implements IMovieRepository {
  final moviesApiProvider = MovieApiProvider();

  @override
  Future<ItemModel> fetchTrendingMovies() => moviesApiProvider.fetchMovieList();
}
