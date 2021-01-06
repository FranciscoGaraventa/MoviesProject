import 'dart:async';
import 'bloc.dart';
import '../models/item_model.dart';
import '../resources/movies_repository.dart';

class MoviesBloc extends Bloc {
  final _repository = MoviesRepository();
  final _moviesFetcherController = StreamController<ItemModel>();

  Stream<ItemModel> get allMovies => _moviesFetcherController.stream;

  @override
  void dispose() {
    _moviesFetcherController.close();
  }

  void fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchTrendingMovies();
    _moviesFetcherController.sink.add(itemModel);
  }

  @override
  void initialize() {}
}
