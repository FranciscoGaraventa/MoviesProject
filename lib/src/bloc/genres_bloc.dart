import 'package:rxdart/rxdart.dart';
import 'bloc.dart';
import 'dart:async';
import '../models/genre_model.dart';
import '../resources/movies_repository.dart';

class GenresBloc extends Bloc {
  final _repository = MoviesRepository();
  final StreamController<GenreModel> _genresFetcherController = BehaviorSubject();

  Stream<GenreModel> get allGenres => _genresFetcherController.stream;

  @override
  void dispose() {
    _genresFetcherController.close();
  }

  void fetchAllGenres() async {
    GenreModel genreModel = await _repository.fetchAllGenres();
    _genresFetcherController.add(genreModel);
  }

  @override
  void initialize() {}
}
