import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/bloc/genres_bloc.dart';
import 'bloc/bloc.dart';
import 'bloc/movies_bloc.dart';
import 'screen/search_screen.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _blocs = <Bloc>[];

  @override
  void initState() {
    super.initState();
    _blocs.add(MoviesBloc());
    _blocs.forEach((bloc) {
      bloc.initialize();
    });
  }

  @override
  void dispose() {
    _blocs.forEach((bloc) {
      bloc.dispose();
    });
    super.dispose();
  }

  T getDesireBloc<T extends Bloc>() {
    return _blocs.firstWhere(
          (bloc) {
        return (bloc is T);
      },
    );
  }

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
        blocMovies: getDesireBloc<MoviesBloc>(),
      ),
    );
  }
}
