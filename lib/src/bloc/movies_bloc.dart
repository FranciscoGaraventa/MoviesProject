import 'dart:async';
import '../models/item_model.dart';
import '../resources/movies_repository.dart';

class MoviesBloc {
  final _repository = MoviesRepository();
  final _moviesFetcherController = StreamController<ItemModel>();

  Stream<ItemModel> get allMovies => _moviesFetcherController.stream;

  void dispose() {
    _moviesFetcherController.close();
  }

  void fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchTrendingMovies();
    _moviesFetcherController.sink.add(itemModel);
  }
}
