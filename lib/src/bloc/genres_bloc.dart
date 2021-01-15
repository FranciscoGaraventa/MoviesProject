import 'bloc.dart';
import 'dart:async';
import '../models/genre_model.dart';
import '../resources/movies_repository.dart';

class GenresBloc extends Bloc {
  final _repository = MoviesRepository();

  final StreamController<GenreModel> _genresFetcherController = StreamController<GenreModel>.broadcast();

  Stream<GenreModel> get allGenres => _genresFetcherController.stream;

  @override
  void initialize() {}

  @override
  void dispose() {
    _genresFetcherController.close();
  }

  void fetchAllGenres() async {
    GenreModel genreModel = await _repository.fetchAllGenres();
    if (!genreModel.getError) {
      _genresFetcherController.sink.add(genreModel);
    } else {
      _genresFetcherController.sink.add(GenreModel());
    }
  }
}
