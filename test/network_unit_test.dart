import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/models/genre_model.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/resources/movie_api_provider.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  http.Client _client;
  MovieApiProvider _movieApiProvider;

  setUp(() {
    _client = MockClient();
    _movieApiProvider = MovieApiProvider()..setClient(_client);
  });

  group('Testing calls that obtains a GenreModel', () {
    test('Testing fetch genre list call', () async {
      when(_client.get('https://api.themoviedb.org/3/genre/movie/list?api_key=4d78e349d0cf62194053e8daf6826b2a'))
          .thenAnswer((_) async => http.Response(
              '{"genres":[{"id":28,"name":"Action"},{"id":12,"name":"Adventure"},{"id":16,"name":"Animation"},{"id":35,"name":"Comedy"},{"id":80,"name":"Crime"},{"id":99,"name":"Documentary"},{"id":18,"name":"Drama"},{"id":10751,"name":"Family"},{"id":14,"name":"Fantasy"},{"id":36,"name":"History"},{"id":27,"name":"Horror"},{"id":10402,"name":"Music"},{"id":9648,"name":"Mystery"},{"id":10749,"name":"Romance"},{"id":878,"name":"Science Fiction"},{"id":10770,"name":"TV Movie"},{"id":53,"name":"Thriller"},{"id":10752,"name":"War"},{"id":37,"name":"Western"}]}',
              200));
      expect(await _movieApiProvider.fetchGenreList(), isInstanceOf<GenreModel>());
    });

    test('Testing fetch genre list with a invalid api key ', () async {
      when(_client.get('https://api.themoviedb.org/3/genre/movie/list?api_key=4d78e349d0cf62194053e8daf6b2a'))
          .thenAnswer((_) async => http.Response(
              '{"status_code":7,"status_message":"Invalid API key: You must be granted a valid key.","success":false}',
              401));
      final item = await _movieApiProvider.fetchGenreList();
      expect(item.getError, true);
    });
  });

  group('Testing calls that obtains a MovieModel', () {
    test('Testing fetch trending movies', () async {
      when(_client.get('https://api.themoviedb.org/3/trending/movie/week?api_key=4d78e349d0cf62194053e8daf6826b2a'))
          .thenAnswer((_) async => http.Response(
              '{"page":1,"results":[{"genre_ids":[14,28,12],"original_language":"en","original_title":"Wonder Woman 1984","poster_path":"/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg","video":false,"vote_average":7.1,"overview":"Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s and finds a formidable foe by the name of the Cheetah.","id":464052,"vote_count":3123,"title":"Wonder Woman 1984","adult":false,"backdrop_path":"/srYya1ZlI97Au4jUYAktDe3avyA.jpg","release_date":"2020-12-16","popularity":2851.612,"media_type":"movie"}],"total_pages":1,"total_results":1}',
              200));
      expect(await _movieApiProvider.fetchTrendingMovies(), isInstanceOf<MovieModel>());
    });

    test('Testing fetch movies by genre ', () async {
      String _genreId = '28';
      when(_client.get(
              'https://api.themoviedb.org/3/discover/movie?api_key=4d78e349d0cf62194053e8daf6826b2a&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=' +
                  _genreId))
          .thenAnswer((_) async => http.Response(
                '{"page":1,"results":[{"adult":false,"backdrop_path":"/lOSdUkGQmbAl5JQ3QoHqBZUbZhC.jpg","genre_ids":[53,28,878],"id":775996,"original_language":"en","original_title":"Outside the Wire","overview":"In the near future, a drone pilot is sent into a deadly militarized zone and must work with an android officer to locate a doomsday device.","popularity":3533.64,"poster_path":"/e6SK2CAbO3ENy52UTzP3lv32peC.jpg","release_date":"2021-01-15","title":"Outside the Wire","video":false,"vote_average":6.5,"vote_count":457}],"total_pages":1,"total_results":1}',
                200,
              ));
      expect(await _movieApiProvider.fetchMovieByGenre(_genreId), isInstanceOf<MovieModel>());
    });

    test('Testing fetch movies by search ', () async {
      String _search = 'harry%20potter';
      when(_client.get(
              'https://api.themoviedb.org/3/search/movie?api_key=4d78e349d0cf62194053e8daf6826b2a&language=en-US&query=' +
                  _search +
                  '&page=1'))
          .thenAnswer((_) async => http.Response(
                '{"page":1,"results":[{"adult":false,"backdrop_path":"/hziiv14OpD73u9gAak4XDDfBKa2.jpg","genre_ids":[12,14],"id":671,"original_language":"en","original_title":"Harry Potter and the Philosopher\'s Stone","overview":"Harry Potter has lived under the stairs at his aunt and uncle\'s house his whole life. But on his 11th birthday, he learns he\'s a powerful wizard -- with a place waiting for him at the Hogwarts School of Witchcraft and Wizardry. As he learns to harness his newfound powers with the help of the school\'s kindly headmaster, Harry uncovers the truth about his parents\' deaths -- and about the villain who\'s to blame.","popularity":160.753,"poster_path":"/wuMc08IPKEatf9rnMNXvIDxqP4W.jpg","release_date":"2001-11-16","title":"Harry Potter and the Philosopher\'s Stone","video":false,"vote_average":7.9,"vote_count":19429}],"total_pages":1,"total_results":1}',
                200,
              ));
      expect(await _movieApiProvider.fetchMoviesBySearch(_search), isInstanceOf<MovieModel>());
    });
  });
}
