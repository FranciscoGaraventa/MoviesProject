import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/bloc.dart';
import 'styles/routes.dart';
import 'bloc/movies_bloc.dart';
import 'bloc/genres_bloc.dart';
import 'bloc/connectivity_bloc.dart';
import 'resources/custom_router.dart';

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
    _blocs.add(GenresBloc());
    _blocs.add(ConnectivityServiceBloc());
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
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => getDesireBloc<MoviesBloc>(),
        ),
        Provider(
          create: (_) => getDesireBloc<GenresBloc>(),
        ),
        Provider(
          create: (_) => getDesireBloc<ConnectivityServiceBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Movies Searcher',
        theme: ThemeData(
          primaryColor: Colors.blue.shade900,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: NavigationRoutes.generateRoute,
        initialRoute: homeRoute,
      ),
    );
  }
}
