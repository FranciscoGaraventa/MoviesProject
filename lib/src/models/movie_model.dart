import 'package:movies_widgets_package/movies_widgets_package.dart';
import 'movie_result.dart';

class MovieModel {
  int _page;
  List<MovieResult> _results = [];
  bool error;

  MovieModel({this.error = false});

  void fromJson(Map<String, dynamic> parsedJson) {
    List<MovieResult> temp = [];
    _page = parsedJson['page'];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      MovieResult result = MovieResult(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<Movie> parseMovie() {
    List<Movie> _movieList = [];
    for (MovieResult result in _results) {
      _movieList.add(Movie(
        id: result.id,
        backdropPath: result.backdropPath,
        title: result.title,
        originalTitle: result.originalTitle,
        originalLanguage: result.originalLanguage,
        releaseDate: result.releaseDate,
        voteAverage: result.voteAverage,
        genreIds: result.genreIds,
        overview: result.overview,
      ));
    }
    return _movieList;
  }

  List<MovieResult> get results => _results;

  int get page => _page;

  bool get getError => error;
}
