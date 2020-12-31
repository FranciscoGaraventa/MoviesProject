import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../styles/dimensions.dart';
import '../widgets/backdrop_image.dart';
import '../widgets/movie_overview.dart';
import '../bloc/genres_bloc.dart';
import '../widgets/staggered_grid_builder.dart';
import '../models/result_model.dart';

class MovieInfo extends StatefulWidget {
  MovieInfo({
    Key key,
    this.movie,
    this.blocGenres,
  }) : super(key: key);

  final Result movie;
  final GenresBloc blocGenres;

  @override
  State<StatefulWidget> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  void initState() {
    super.initState();
    widget.blocGenres.fetchAllGenres();
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            BackdropImage(
              size: MediaQuery.of(context).size,
              movie: widget.movie,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Dimension.movieInfoVerticalPadding,
              ),
              child: StreamBuilder(
                stream: widget.blocGenres.allGenres,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: Dimension.staggeredGridPadding,
                        right: Dimension.staggeredGridPadding,
                      ),
                      child: StaggeredGridBuilder(
                        resultData: snapshot.data,
                        movie: widget.movie,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            MovieOverview(
              movie: widget.movie,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }
}
