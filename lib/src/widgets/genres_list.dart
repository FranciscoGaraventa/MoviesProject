import 'package:flutter/material.dart';
import 'empty_state.dart';
import '../styles/routes.dart';
import '../models/genre_model.dart';

class GenresList extends StatelessWidget {
  final GenreModel resultGenres;

  GenresList({this.resultGenres});

  Widget _buildContent() {
    return SingleChildScrollView(
      child: resultGenres.genres.length > 0
          ? ListView.builder(
              itemCount: resultGenres.genres.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('${resultGenres.genres[index].name}'),
                  onTap: () {
                    Navigator.pushNamed(context, movieByGenre, arguments: resultGenres.genres[index]);
                  },
                );
              },
            )
          : EmptyState(
              icon: Icons.local_movies,
              text: 'GENRES UNAVAILABLE',
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }
}
