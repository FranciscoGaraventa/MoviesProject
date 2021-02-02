import 'package:flutter/material.dart';
import 'package:movies_widgets_package/movies_widgets_package.dart';
import '../styles/routes.dart';
import '../events/search_event.dart';

class MoviesEvents extends StatelessWidget {
  final SearchEvent eventResult;
  final String title;

  const MoviesEvents({
    Key key,
    this.eventResult,
    this.title,
  }) : super(key: key);

  Widget _buildContent(BuildContext context) {
    switch (eventResult.stateType) {
      case SearchStateType.loading:
        return CircularProgressIndicator();
      case SearchStateType.error:
        return MovieEventError(
          messageError: 'NO SERVICE AVAILABLE',
        );
      case SearchStateType.success:
        return MoviesGridView(
          movieList: eventResult.movies.parseMovie(),
          defaultImageRoute: 'assets/images/imageNoAvailable.svg',
          onItemClick: (context, movie) => Navigator.of(context).pushNamed(movieInfo, arguments: movie),
        );
      case SearchStateType.initial:
      case SearchStateType.empty:
        return MovieEventEmpty(
          text: 'NO MOVIES AVAILABLE',
          defaultImageRoute: 'assets/images/moviesNoAvailable.png',
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }
}
