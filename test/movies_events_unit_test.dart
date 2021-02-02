import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/events/search_event.dart';
import 'package:movies_app/src/widgets/movies_events.dart';
import 'package:movies_app/src/resources/movie_api_provider.dart';
import 'package:movies_widgets_package/movies_widgets_package.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  http.Client _client;
  MovieApiProvider _movieApiProvider;

  setUp(() {
    _client = MockClient();
    _movieApiProvider = MovieApiProvider()..setClient(_client);
  });

  Future<MovieModel> _mockTrendingMovies() async {
    when(_client.get('https://api.themoviedb.org/3/trending/movie/week?api_key=4d78e349d0cf62194053e8daf6826b2a'))
        .thenAnswer((_) async => http.Response(
            '{"page":1,"results":[{"genre_ids":[14,28,12],"original_language":"en","original_title":"Wonder Woman 1984","poster_path":"/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg","video":false,"vote_average":7.0,"overview":"Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s and finds a formidable foe by the name of the Cheetah.","id":464052,"vote_count":3261,"title":"Wonder Woman 1984","adult":false,"backdrop_path":"/srYya1ZlI97Au4jUYAktDe3avyA.jpg","release_date":"2020-12-16","popularity":3291.297,"media_type":"movie"},{"original_language":"en","original_title":"The Little Things","poster_path":"/1ihJ0yr7v6YqP6zvPVpPKUrOuQ3.jpg","video":false,"vote_average":6.4,"overview":"Deputy Sheriff Joe \"Deke\" Deacon joins forces with Sgt. Jim Baxter to search for a serial killer who\'s terrorizing Los Angeles. As they track the culprit, Baxter is unaware that the investigation is dredging up echoes of Deke\'s past, uncovering disturbing secrets that could threaten more than his case.","release_date":"2021-01-27","vote_count":109,"title":"The Little Things","adult":false,"backdrop_path":"/vfuzELmhBjBTswXj2Vqxnu5ge4g.jpg","id":602269,"genre_ids":[53,80],"popularity":320.694,"media_type":"movie"},{"adult":false,"backdrop_path":"/bblKpucB0XbyQBmfXsaRN985Rgh.jpg","genre_ids":[18],"id":458220,"original_language":"en","original_title":"Palmer","overview":"After 12 years in prison, former high school football star Eddie Palmer returns home to put his life back together—and forms an unlikely bond with Sam, an outcast boy from a troubled home. But Eddie\'s past threatens to ruin his new life and family.","poster_path":"/xSDdRAjxKAGi8fUBLOqSrBhJmF0.jpg","release_date":"2021-01-29","title":"Palmer","video":false,"vote_average":8.3,"vote_count":81,"popularity":149.691,"media_type":"movie"}],"total_pages":1,"total_results":3}',
            200));
    MovieModel _trendingMovies = await _movieApiProvider.fetchTrendingMovies();
    return _trendingMovies;
  }

  Widget _buildWidget(SearchEvent searchEvent) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: MoviesEvents(
            eventResult: searchEvent,
          ),
        ),
      ),
    );
  }

  group('Testing movie events state types [loading, empty, success, initial, error]', () {
    testWidgets('Check when state type is loading', (WidgetTester tester) async {
      await tester.pumpWidget(_buildWidget(SearchEvent(stateType: SearchStateType.loading)));

      expect(find.byKey(ValueKey('stateTypeLoading')), findsOneWidget);
    });

    testWidgets('Check when stage type is empty', (WidgetTester tester) async {
      await tester.pumpWidget(_buildWidget(SearchEvent(stateType: SearchStateType.empty)));

      expect(find.byType(MovieEventEmpty), findsOneWidget);
    });

    testWidgets('Check when stage type is error', (WidgetTester tester) async {
      await tester.pumpWidget(_buildWidget(SearchEvent(stateType: SearchStateType.error)));

      expect(find.byType(MovieEventError), findsOneWidget);
    });

    testWidgets('Check when stage type is initial', (WidgetTester tester) async {
      await tester.pumpWidget(_buildWidget(SearchEvent(stateType: SearchStateType.initial)));

      expect(find.byType(MovieEventEmpty), findsOneWidget);
    });

    testWidgets('Check when stage type is success', (WidgetTester tester) async {
      await tester.runAsync(() async => {
            await tester.pumpWidget(
              MaterialApp(
                home: Scaffold(
                  body: MoviesEvents(
                    eventResult: SearchEvent(
                      movies: await _mockTrendingMovies(),
                      stateType: SearchStateType.success,
                    ),
                  ),
                ),
              ),
            )
          });

      expect(find.byType(MoviesGridView), findsOneWidget);
    });
  });
}
