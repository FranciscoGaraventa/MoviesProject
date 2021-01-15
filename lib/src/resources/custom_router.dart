import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/genre_result_model.dart';
import '../models/result_model.dart';
import '../screen/movie_info_screen.dart';
import '../screen/movies_by_genre.dart';
import '../screen/main_screen.dart';
import '../styles/routes.dart';

class NavigationRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => MainScreen(
            title: 'THE MOVIE SEARCHER',
            icon: IconData(0xe890, fontFamily: 'MaterialIcons'),
          ),
        );
      case movieByGenre:
        var resultGenres = settings.arguments as GenreResult;
        return MaterialPageRoute(
          builder: (_) => MoviesByGenre(
            genre: resultGenres,
          ),
        );
      case movieInfo:
        var movie = settings.arguments as Result;
        return MaterialPageRoute(
          builder: (_) => MovieInfo(
            movie: movie,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
