import 'dart:convert';
import 'package:http/http.dart';
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
      throw Exception('Failed to load post');
    }
  }
}
