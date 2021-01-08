import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../bloc/movies_bloc.dart';
import '../events/movie_event.dart';
import '../events/search_event.dart';
import '../widgets/search_events.dart';

class CustomMoviesSearch extends SearchDelegate<ItemModel> {
  final MoviesBloc moviesBloc;

  CustomMoviesSearch({this.moviesBloc});

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
    moviesBloc.fetchMovies(MovieEvent.loadMoviesBySearch, query);
    return StreamBuilder(
      stream: moviesBloc.allMovies,
      initialData: SearchEvent(
        stateType: SearchStateType.initial,
      ),
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
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
