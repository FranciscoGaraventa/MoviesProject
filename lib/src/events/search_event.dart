import '../models/item_model.dart';

class SearchEvent {
  SearchEvent({
    this.movies,
    this.stateType,
  });

  final ItemModel movies;
  final SearchStateType stateType;
}

enum SearchStateType {
  loading,
  success,
  error,
  initial,
}
