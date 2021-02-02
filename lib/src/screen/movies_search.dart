import 'package:flutter/material.dart';
import 'package:movies_widgets_package/movies_widgets_package.dart';
import 'package:provider/provider.dart';
import '../bloc/movies_bloc.dart';
import '../models/movie_model.dart';
import '../events/movie_event.dart';
import '../widgets/search_events.dart';

class CustomMoviesSearch extends SearchDelegate<MovieModel> {
  @override
  final String searchFieldLabel;

  CustomMoviesSearch(this.searchFieldLabel);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.delete_rounded),
        color: Colors.blueGrey.shade800,
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: BackButtonIcon(),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      Provider.of<MoviesBloc>(context).fetchMoviesByQuery(MovieEvent.loadMoviesBySearch, query);
      return StreamBuilder(
        stream: Provider.of<MoviesBloc>(context).allMovies,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return SearchStates(
              results: snapshot.data,
            );
          }
        },
      );
    } else {
      return MovieEventInitial(
        initialMessage: 'INSERT MOVIE NAME TO SEARCH',
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return MovieEventInitial(
      initialMessage: 'INSERT MOVIE NAME TO SEARCH',
    );
  }
}
