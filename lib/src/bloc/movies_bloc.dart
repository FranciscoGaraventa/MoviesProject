import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'bloc.dart';
import '../events/search_event.dart';
import '../models/item_model.dart';
import '../events/movie_event.dart';
import '../resources/movies_repository.dart';

class MoviesBloc extends Bloc {
  final _repository = MoviesRepository();
  final StreamController<SearchEvent> _moviesFetcherController =
      BehaviorSubject();

  Stream<SearchEvent> get allMovies => _moviesFetcherController.stream;

  @override
  void dispose() {
    _moviesFetcherController.close();
  }

  void fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchTrendingMovies();
    if (itemModel != null) {
      _moviesFetcherController.add(
          SearchEvent(movies: itemModel, stateType: SearchStateType.success));
    } else {
      _moviesFetcherController
          .add(SearchEvent(stateType: SearchStateType.error));
    }
  }

  void fetchMoviesByGenre(String genreId) async {
    ItemModel itemModel =
        await _repository.fetchMovieByGenre(genreId);
    _moviesFetcherController.add(
        SearchEvent(movies: itemModel, stateType: SearchStateType.success));
  }

  void fetchMoviesBySearch(String query) async {
    ItemModel itemModel = await _repository.fetchMoviesBySearch(query);
    if (itemModel != null) {
      if (itemModel.results.isNotEmpty) {
        _moviesFetcherController.add(
            SearchEvent(movies: itemModel, stateType: SearchStateType.success));
      } else {
        _moviesFetcherController
            .add(SearchEvent(stateType: SearchStateType.error));
      }
    } else {
      _moviesFetcherController
          .add(SearchEvent(stateType: SearchStateType.initial));
    }
  }

  void _mapEventToState(MovieEvent event, String query) {
    switch (event) {
      case MovieEvent.loadMoviesBySearch:
        fetchMoviesBySearch(query);
        break;
      case MovieEvent.loadMoviesByGenreId:
        fetchMoviesByGenre(query);
        break;
      case MovieEvent.loadTrendingMovies:
        fetchAllMovies();
        break;
    }
  }

  void _fetchData(MovieEvent event, String query) async {
    Future.delayed(const Duration(milliseconds: 500), () {
      _mapEventToState(event, query);
    });
  }

  void fetchMovies(MovieEvent event, [String query = '']) {
    _moviesFetcherController
        .add(SearchEvent(stateType: SearchStateType.loading));
    _fetchData(event, query);
  }

  @override
  void initialize() {}
}
