import 'package:flutter/material.dart';
import 'package:movies_widgets_package/movies_widgets_package.dart';
import '../styles/routes.dart';
import '../screen/main_screen.dart';
import '../screen/movies_by_genre.dart';
import '../screen/movie_info_screen.dart';

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
        var genre = settings.arguments as Genre;
        return MaterialPageRoute(
          builder: (_) => MoviesByGenre(
            genre: genre,
          ),
        );
      case movieInfo:
        var movie = settings.arguments as Movie;
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
