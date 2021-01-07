import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../bloc/genres_bloc.dart';
import '../bloc/movies_bloc.dart';
import '../widgets/movie_list.dart';
import '../widgets/genres_list.dart';
import '../styles/dimensions.dart';
import '../styles/styles.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({
    Key key,
    this.title,
    this.icon,
    this.blocMovies,
    this.blocGenres,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final MoviesBloc blocMovies;
  final GenresBloc blocGenres;

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    widget.blocMovies.fetchAllMovies();
    widget.blocGenres.fetchAllGenres();
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
            onPressed: () {},
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
          StreamBuilder(
            stream: widget.blocGenres.allGenres,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GenresList(
                  resultGenres: snapshot.data,
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ]),
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
}
