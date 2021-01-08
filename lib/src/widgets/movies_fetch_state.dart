import 'package:flutter/material.dart';
import 'movie_list.dart';
import '../styles/dimensions.dart';
import '../events/search_event.dart';

class MoviesFetchState extends StatelessWidget {
  final SearchEvent eventResult;

  const MoviesFetchState({
    Key key,
    this.eventResult,
  }) : super(key: key);

  Widget _buildContent() {
    switch (eventResult.stateType) {
      case SearchStateType.loading:
        return CircularProgressIndicator();
      case SearchStateType.initial:
        return Text('SEARCH');
      case SearchStateType.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.error),
                iconSize: Dimension.iconSearchTypeSize,
              ),
            ],
          ),
        );
      case SearchStateType.success:
        if (eventResult.movies == null)
          return Text('NOTHING TO SEARCH');
        else {
          return MovieList(
            resultData: eventResult.movies,
          );
        }
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: _buildContent());
  }
}
