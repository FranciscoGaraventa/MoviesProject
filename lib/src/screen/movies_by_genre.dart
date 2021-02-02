import 'package:flutter/material.dart';
import 'package:movies_widgets_package/movies_widgets_package.dart';
import 'package:provider/provider.dart';
import '../bloc/movies_bloc.dart';
import '../events/movie_event.dart';
import '../widgets/movies_events.dart';
import '../bloc/connectivity_bloc.dart';
import '../events/connectivity_status.dart';

class MoviesByGenre extends StatefulWidget {
  final Genre genre;

  MoviesByGenre({
    Key key,
    this.genre,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MoviesGenreList();
}

class _MoviesGenreList extends State<MoviesByGenre> {
  void _fetchMoviesByGenre() {
    Provider.of<MoviesBloc>(context, listen: false)
        .fetchMoviesByQuery(MovieEvent.loadMoviesByGenreId, widget.genre.id.toString());
  }

  @override
  void initState() {
    super.initState();
    _fetchMoviesByGenre();
    Provider.of<ConnectivityServiceBloc>(context, listen: false).connectionStatusController.stream.listen((event) {
      if (event == ConnectivityStatus.Online) {
        Future.delayed(Duration(seconds: 3), () {
          _fetchMoviesByGenre();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genre.name),
      ),
      body: Center(
        child: StreamBuilder(
          stream: Provider.of<MoviesBloc>(context, listen: false).allMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MoviesEvents(
                title: widget.genre.name,
                eventResult: snapshot.data,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
