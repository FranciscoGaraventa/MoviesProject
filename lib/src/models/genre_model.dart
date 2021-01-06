import 'genre_result_model.dart';

class GenreModel {
  List<GenreResult> _genres = [];

  GenreModel.fromJson(Map<String, dynamic> parsedJson) {
    List<GenreResult> temp = [];
    if (parsedJson != null) {
      for (int i = 0; i < parsedJson['genres'].length; i++) {
        GenreResult result = GenreResult(parsedJson['genres'][i]);
        temp.add(result);
      }
    }
    _genres = temp;
  }

  List<GenreResult> get genres => _genres;
}
