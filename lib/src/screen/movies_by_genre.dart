import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/genre_result_model.dart';
import '../bloc/movies_bloc.dart';
import '../widgets/movie_list.dart';

class MoviesByGenre extends StatefulWidget {
  final GenreResult genre;
  final MoviesBloc blocMovies;

  MoviesByGenre({
    Key key,
    this.genre,
    this.blocMovies,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MoviesGenreList();
}

class _MoviesGenreList extends State<MoviesByGenre> {
  @override
  void initState() {
    super.initState();
    widget.blocMovies.fetchMoviesByGenre(widget.genre.id);
  }

  Widget _buildContent() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genre.name),
      ),
      body: Center(
        child: StreamBuilder(
          stream: widget.blocMovies.allMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MovieList(
                resultData: snapshot.data,
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }
}
