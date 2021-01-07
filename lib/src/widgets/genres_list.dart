import 'package:flutter/material.dart';
import '../bloc/movies_bloc.dart';
import '../screen/movies_by_genre.dart';
import '../models/genre_model.dart';

class GenresList extends StatelessWidget {
  final GenreModel resultGenres;

  GenresList({this.resultGenres});

  Widget _buildContent() {
    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: resultGenres.genres.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('${resultGenres.genres[index].name}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MoviesByGenre(
                    genre: resultGenres.genres[index],
                    blocMovies: MoviesBloc(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }
}
