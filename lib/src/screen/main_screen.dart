import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:movies_widgets_package/movies_widgets_package.dart';
import 'package:provider/provider.dart';
import 'movies_search.dart';
import '../styles/styles.dart';
import '../styles/routes.dart';
import '../bloc/movies_bloc.dart';
import '../bloc/genres_bloc.dart';
import '../styles/dimensions.dart';
import '../events/movie_event.dart';
import '../events/search_event.dart';
import '../widgets/movies_events.dart';
import '../bloc/connectivity_bloc.dart';
import '../events/connectivity_status.dart';

class MainScreen extends StatefulWidget {
  MainScreen({
    Key key,
    this.title,
    this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Genre> _genres;
  SearchEvent _movies;
  var connectionStatus;

  void _genreList() {
    Provider.of<GenresBloc>(context, listen: false).allGenres.listen((event) {
      _genres = event.parseGenres();
      setState(() {});
    });
  }

  void _moviesList() {
    Provider.of<MoviesBloc>(context, listen: false).trendingMovies.listen((event) {
      _movies = event;
      setState(() {});
    });
  }

  void _updateInformation() {
    Provider.of<MoviesBloc>(context, listen: false).fetchTrendingByEvent(MovieEvent.loadTrendingMovies);
    Provider.of<GenresBloc>(context, listen: false).fetchAllGenres();
  }

  @override
  void initState() {
    super.initState();
    _moviesList();
    _genreList();
    _updateInformation();
    Provider.of<ConnectivityServiceBloc>(context, listen: false).connectionStatusController.stream.listen((event) {
      if (event == ConnectivityStatus.Online) {
        Future.delayed(Duration(seconds: 3), () {
          _updateInformation();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
            ),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: Dimension.searchScreenTextFS,
                fontWeight: FontWeight.bold,
                foreground: Paint()..shader = linearGradient,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: CustomMoviesSearch('Search movies...'),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(children: [
          Container(
            height: Dimension.searchScreenContainerGenres,
            child: DrawerHeader(
                child: Text(
                  'MOVIES GENRES',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                )),
          ),
          GenresList(
            onTapAction: (context, movie) => Navigator.of(context).pushNamed(movieByGenre, arguments: movie),
            emptyStateText: 'GENRES UNAVAILABLE',
            defaultImageRoute: 'assets/images/imageNoAvailable.svg',
            genresList: _genres,
          ),
        ]),
      ),
      body: Center(
        child: _movies != null
            ? MoviesEvents(
                eventResult: _movies,
              )
            : Container(),
      ),
    );
  }
}
