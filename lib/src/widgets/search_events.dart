import 'package:flutter/material.dart';
import '../bloc/genres_bloc.dart';
import '../styles/dimensions.dart';
import '../models/item_model.dart';
import '../events/search_event.dart';
import '../screen/movie_info_screen.dart';

class SearchStates extends StatelessWidget {
  final SearchEvent results;

  const SearchStates({
    Key key,
    this.results,
  }) : super(key: key);

  Widget _buildContent() {
    switch (results.stateType) {
      case SearchStateType.loading:
        return CircularProgressIndicator();
      case SearchStateType.initial:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.search),
                iconSize: Dimension.iconSearchTypeSize,
              ),
            ],
          ),
        );
      case SearchStateType.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.search_off),
                iconSize: Dimension.iconSearchTypeSize,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.grey.shade700),
                  children: [
                    TextSpan(
                      text: 'NO RESULT FOUND',
                      style: TextStyle(
                          fontSize: Dimension.searchEventTextFontSize,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case SearchStateType.success:
        ItemModel _movies = results.movies;
        return ListView.builder(
          itemCount: _movies.results.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_movies.results[index].originalTitle),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieInfo(
                      movie: _movies.results[index],
                      blocGenres: GenresBloc(),
                    ),
                  ),
                );
              },
            );
          },
        );
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
