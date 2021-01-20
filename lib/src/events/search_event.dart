import '../models/movie_model.dart';

class SearchEvent {
  SearchEvent({
    this.movies,
    this.stateType,
  });

  final MovieModel movies;
  final SearchStateType stateType;
}

enum SearchStateType {
  loading,
  success,
  error,
  initial,
  empty,
}
