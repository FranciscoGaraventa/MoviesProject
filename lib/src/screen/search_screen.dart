import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../widgets/mock_genres.dart';
import '../widgets/mock_movies.dart';
import '../styles/dimensions.dart';
import '../styles/styles.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({
    Key key,
    this.title,
    this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
        child: MockGenres(),
      ),
      body: Center(
        child: MockMovies(),
      ),
    );
  }
}
