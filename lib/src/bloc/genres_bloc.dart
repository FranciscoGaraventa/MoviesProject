import 'package:rxdart/rxdart.dart';
import 'bloc.dart';
import 'dart:async';
import '../models/genre_model.dart';
import '../resources/movies_repository.dart';

class GenresBloc extends Bloc {
  final _repository = MoviesRepository();
  final StreamController<GenreModel> _genresFetchercontroller = BehaviorSubject();

  Stream<GenreModel> get allGenres => _genresFetchercontroller.stream;

  @override
  void dispose() {
    _genresFetchercontroller.close();
  }

  void fetchAllGenres() async {
    GenreModel genreModel = await _repository.fetchAllGenres();
    _genresFetchercontroller.add(genreModel);
  }

  @override
  void initialize() {}
}
