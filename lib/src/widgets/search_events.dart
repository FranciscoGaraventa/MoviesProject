import 'package:flutter/material.dart';
import 'package:movies_app/src/widgets/empty_state.dart';
import 'error_state.dart';
import 'initial_state.dart';
import '../styles/routes.dart';
import '../styles/dimensions.dart';
import '../models/item_model.dart';
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
        return InitialState();
      case SearchStateType.empty:
        return EmptyState(
          icon: Icons.search_off,
          text: 'NO RESULT FOUND',
        );
      case SearchStateType.success:
        ItemModel _movies = results.movies;
        return ListView.builder(
          itemCount: _movies.results.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_movies.results[index].originalTitle),
              onTap: () {
                Navigator.pushNamed(context, movieInfo, arguments: _movies.results[index]);
              },
            );
          },
        );
      case SearchStateType.error:
        return ErrorState();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: _buildContent(context));
  }
}
