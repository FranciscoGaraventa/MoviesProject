import 'package:flutter/material.dart';
import '../events/movie_event.dart';
import '../bloc/movies_bloc.dart';
import '../models/genre_result_model.dart';
import '../widgets/movies_fetch_state.dart';

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
    widget.blocMovies.fetchMovies(
        MovieEvent.loadMoviesByGenreId, widget.genre.id.toString());
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
              return MoviesFetchState(
                eventResult: snapshot.data,
              );
            }
            return Container();
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
