import 'package:movies_widgets_package/movies_widgets_package.dart';
import 'genre_result.dart';

class GenreModel {
  List<GenreResult> _genres = [];
  bool error;

  GenreModel({this.error = false});

  void fromJson(Map<String, dynamic> parsedJson) {
    List<GenreResult> temp = [];
    if (parsedJson != null) {
      for (int i = 0; i < parsedJson['genres'].length; i++) {
        GenreResult result = GenreResult(parsedJson['genres'][i]);
        temp.add(result);
      }
    }
    _genres = temp;
  }

  List<Genre> parseGenres() {
    List<Genre> _genresList = [];
    for (GenreResult genre in _genres) {
      _genresList.add(Genre(
        id: genre.id,
        name: genre.name,
      ));
    }
    return _genresList;
  }

  List<GenreResult> get genres => _genres;

  void setGenres(List<GenreResult> resGenres){
    _genres = resGenres;
  }

  bool get getError => error;
}
