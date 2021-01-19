import 'dart:async';
import 'bloc.dart';
import '../models/item_model.dart';
import '../events/movie_event.dart';
import '../events/search_event.dart';
import '../resources/movies_repository.dart';

class MoviesBloc extends Bloc {
  final _repository = MoviesRepository();
  final StreamController<SearchEvent> _moviesFetcherController = StreamController<SearchEvent>.broadcast();
  final StreamController<SearchEvent> _trendingFetcherController = StreamController<SearchEvent>.broadcast();

  Stream<SearchEvent> get allMovies => _moviesFetcherController.stream;

  Stream<SearchEvent> get trendingMovies => _trendingFetcherController.stream;

  @override
  void dispose() {
    _moviesFetcherController.close();
    _trendingFetcherController.close();
  }

  @override
  void initialize() {}

  void fetchMoviesBySearch(String query) async {
    ItemModel itemModel = await _repository.fetchMoviesBySearch(query);
    if (!itemModel.getError) {
      if (itemModel.results.isNotEmpty) {
        _moviesFetcherController.sink.add(SearchEvent(movies: itemModel, stateType: SearchStateType.success));
      } else {
        _moviesFetcherController.sink.add(SearchEvent(stateType: SearchStateType.empty));
      }
    } else {
      _moviesFetcherController.sink.add(SearchEvent(stateType: SearchStateType.error));
    }
  }

  void fetchMoviesByGenre(String genreId) async {
    ItemModel itemModel = await _repository.fetchMovieByGenre(genreId);
    if (!itemModel.getError) {
      if (itemModel.results.isNotEmpty) {
        _moviesFetcherController.sink.add(SearchEvent(movies: itemModel, stateType: SearchStateType.success));
      } else {
        _moviesFetcherController.sink.add(SearchEvent(stateType: SearchStateType.empty));
      }
    } else {
      _moviesFetcherController.sink.add(SearchEvent(stateType: SearchStateType.error));
    }
  }

  void fetchTrendingMovies() async {
    ItemModel itemModel = await _repository.fetchTrendingMovies();
    if (!itemModel.getError) {
      if (itemModel.results.isNotEmpty) {
        _trendingFetcherController.add(SearchEvent(movies: itemModel, stateType: SearchStateType.success));
      } else {
        _trendingFetcherController.add(SearchEvent(stateType: SearchStateType.empty));
      }
    } else {
      _trendingFetcherController.add(SearchEvent(stateType: SearchStateType.error));
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
        fetchTrendingMovies();
        break;
    }
  }

  void _fetchData(MovieEvent event, [String query = '']) async {
    Future.delayed(const Duration(milliseconds: 500), () {
      _mapEventToState(event, query);
    });
  }

  void fetchMoviesByQuery(MovieEvent event, String query) {
    _moviesFetcherController.sink.add(SearchEvent(stateType: SearchStateType.loading));
    _fetchData(event, query);
  }

  void fetchTrendingByEvent(MovieEvent event) {
    _trendingFetcherController.sink.add(SearchEvent(stateType: SearchStateType.loading));
    _fetchData(event);
  }
}
