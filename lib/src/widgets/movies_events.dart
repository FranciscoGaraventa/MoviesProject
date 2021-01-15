import 'package:flutter/material.dart';
import 'empty_state.dart';
import 'error_state.dart';
import 'movie_grid.dart';
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
        return ErrorState();
      case SearchStateType.success:
        return MovieGrid(
          resultData: eventResult.movies,
        );
      case SearchStateType.initial:
      case SearchStateType.empty:
        return EmptyState(
          text: 'NO MOVIES AVAILABLE',
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
