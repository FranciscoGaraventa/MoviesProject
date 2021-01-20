import 'package:flutter/material.dart';
import 'package:movies_widgets_package/movies_widgets_package.dart';
import '../styles/routes.dart';
import '../events/search_event.dart';

class SearchStates extends StatelessWidget {
  final SearchEvent results;

  const SearchStates({
    Key key,
    this.results,
  }) : super(key: key);

  Widget _buildContent(BuildContext context) {
    switch (results.stateType) {
      case SearchStateType.loading:
        return CircularProgressIndicator();
      case SearchStateType.initial:
        return MovieEventInitial(
          initialMessage: 'INSERT MOVIE NAME TO SEARCH',
        );
      case SearchStateType.empty:
        return MovieEventEmpty(
          icon: Icons.search_off,
          text: 'NO RESULT FOUND',
          defaultImageRoute: 'assets/images/imageNoAvailable',
        );
      case SearchStateType.success:
        List<Movie> _movieList = results.movies.parseMovie();
        return ListView.builder(
          itemCount: _movieList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_movieList[index].originalTitle),
              onTap: () {
                Navigator.pushNamed(context, movieInfo, arguments: _movieList[index]);
              },
            );
          },
        );
      case SearchStateType.error:
        return MovieEventError(
          messageError: 'NO SERVICE AVAILABLE',
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: _buildContent(context));
  }
}
