import 'dart:convert';
import 'package:http/http.dart';
import 'base_url.dart';
import '../models/item_model.dart';
import '../models/genre_model.dart';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '4d78e349d0cf62194053e8daf6826b2a';

  Future<ItemModel> fetchMovieList() async {
    final response = await client.get(BaseUrl.trendingMovies + '$_apiKey');
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<GenreModel> fetchGenreList() async {
    final response = await client.get(BaseUrl.genresMovies + '$_apiKey');
    if (response.statusCode == 200) {
      return GenreModel.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<ItemModel> fetchMovieByGenre(String genreId) async {
    final response = await client.get(BaseUrl.moviesByGenreBasicUrl +
        '$_apiKey' +
        BaseUrl.moviesWithGenres +
        genreId);
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<ItemModel> fetchMoviesBySearch(String query) async {
    final response = await client.get(BaseUrl.moviesBySearchBasicUrl +
        '$_apiKey' +
        BaseUrl.moviesBySearchQuery +
        query +
        BaseUrl.moviesBySearchPages);
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}
