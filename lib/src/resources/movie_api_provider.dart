import 'dart:convert';
import 'package:http/http.dart';
import 'package:movies_app/src/models/genre_model.dart';
import 'base_url.dart';
import '../models/item_model.dart';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '4d78e349d0cf62194053e8daf6826b2a';

  Future<ItemModel> fetchMovieList() async {
    final response = await client.get(
        BaseUrl.trendingMovies+'$_apiKey');
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<GenreModel> fetchGenreList() async {
    final response = await client.get(
      BaseUrl.genresMovies+'$_apiKey');
    if (response.statusCode == 200){
      return GenreModel.fromJson(json.decode(response.body));
    }else{
      return null;
    }
  }
}
