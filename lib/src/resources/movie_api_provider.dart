import 'dart:convert';
import 'package:http/http.dart';
import 'base_url.dart';
import '../models/movie_model.dart';
import '../models/genre_model.dart';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '4d78e349d0cf62194053e8daf6826b2a';

  Future<MovieModel> fetchTrendingMovies() async {
    try {
      final response = await client.get(BaseUrl.trendingMovies + '$_apiKey');
      if (response.statusCode == 200) {
        return MovieModel()..fromJson(json.decode(response.body));
      } else {
        return MovieModel(error: true);
      }
    } catch (e) {
      return MovieModel(error: true);
    }
  }

  Future<GenreModel> fetchGenreList() async {
    try {
      final response = await client.get(BaseUrl.genresMovies + '$_apiKey');
      if (response.statusCode == 200) {
        return GenreModel()..fromJson(json.decode(response.body));
      } else {
        return GenreModel(error: true);
      }
    } catch (e) {
      return GenreModel(error: true);
    }
  }

  Future<MovieModel> fetchMovieByGenre(String genreId) async {
    try {
      final response =
          await client.get(BaseUrl.moviesByGenreBasicUrl + '$_apiKey' + BaseUrl.moviesWithGenres + genreId);
      if (response.statusCode == 200) {
        return MovieModel()..fromJson(json.decode(response.body));
      } else {
        return MovieModel(error: true);
      }
    } catch (e) {
      return MovieModel(error: true);
    }
  }

  Future<MovieModel> fetchMoviesBySearch(String query) async {
    try {
      final response = await client.get(BaseUrl.moviesBySearchBasicUrl +
          '$_apiKey' +
          BaseUrl.moviesBySearchQuery +
          query +
          BaseUrl.moviesBySearchPages);
      if (response.statusCode == 200) {
        return MovieModel()..fromJson(json.decode(response.body));
      } else {
        return MovieModel(error: true);
      }
    } catch (e) {
      return MovieModel(error: true);
    }
  }
}
