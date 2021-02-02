import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/bloc/movies_bloc.dart';
import 'package:movies_app/src/events/movie_event.dart';
import 'package:movies_app/src/events/search_event.dart';

void main() async {
  MoviesBloc _movieBloc;

  setUp(() {
    _movieBloc = MoviesBloc();
  });

  group('BloC testing', () {
    test('Movie BloC testing fetchTrendingMovies', () async {
      _movieBloc.fetchTrendingMovies();
      _movieBloc.trendingMovies.listen(expectAsync1((value) {
        expect(value.stateType, SearchStateType.success);
      }));
    });

    test('Movie BloC testing fetchMoviesByGenre', () async {
      _movieBloc.fetchMoviesByGenre('14');
      _movieBloc.allMovies.listen(expectAsync1((value) {
        expect(value.stateType, SearchStateType.success);
      }));
    });

    test('Movie BloC testing fetchMoviesBySearch', () async {
      _movieBloc.fetchMoviesBySearch('harry%20potter');
      _movieBloc.allMovies.listen(expectAsync1((value) {
        expect(value.stateType, SearchStateType.success);
      }));
    });

    test('Movie BloC testing fetchMoviesByQuery', () async {
      _movieBloc.fetchMoviesByQuery(MovieEvent.loadMoviesBySearch, 'Soul');
      _movieBloc.allMovies.listen(expectAsync1((value) {
        expect(value.stateType, SearchStateType.success);
      }));
    });

    test('Movie BloC testing fetchTrendingByEvent', () async {
      _movieBloc.fetchTrendingByEvent(MovieEvent.loadTrendingMovies);
      _movieBloc.trendingMovies.listen(expectAsync1((value) {
        expect(value.stateType, SearchStateType.success);
      }));
    });
  });
}
