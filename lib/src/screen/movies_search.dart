import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/movies_bloc.dart';
import '../models/item_model.dart';
import '../events/movie_event.dart';
import '../widgets/initial_state.dart';
import '../widgets/search_events.dart';

class CustomMoviesSearch extends SearchDelegate<ItemModel> {
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
      return InitialState();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return InitialState();
  }
}
