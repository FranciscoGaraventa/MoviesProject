import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bloc/movies_bloc.dart';
import 'screen/search_screen.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies Searcher',
      theme: ThemeData(
        primaryColor: Colors.blue.shade900,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SearchScreen(
        title: 'THE MOVIE SEARCHER',
        icon: IconData(0xe890, fontFamily: 'MaterialIcons'),
        blocMovies: MoviesBloc(),
      ),
    );
  }
}
