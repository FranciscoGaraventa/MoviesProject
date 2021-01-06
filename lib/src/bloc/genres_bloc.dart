import 'bloc.dart';
import 'dart:async';
import '../models/genre_model.dart';
import '../resources/movies_repository.dart';

class GenresBloc extends Bloc {
  final _repository = MoviesRepository();
  final _genresFetcherController = StreamController<GenreModel>();

  Stream<GenreModel> get allGenres => _genresFetcherController.stream;

  @override
  void dispose() {
    _genresFetcherController.close();
  }

  void fetchAllGenres() async {
    GenreModel genreModel = await _repository.fetchAllGenres();
    _genresFetcherController.sink.add(genreModel);
  }

  @override
  void initialize() {}
}
