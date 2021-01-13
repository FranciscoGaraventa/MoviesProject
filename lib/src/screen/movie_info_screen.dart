import 'package:flutter/material.dart';
import '../bloc/genres_bloc.dart';
import '../styles/dimensions.dart';
import '../models/result_model.dart';
import '../widgets/backdrop_image.dart';
import '../widgets/movie_overview.dart';
import '../widgets/backdrop_rating.dart';
import '../widgets/staggered_grid_builder.dart';

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

  Widget _customScrollView() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: Dimension.movieInfoAppBarHeight,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              '${widget.movie.originalTitle}',
              style: TextStyle(
                fontSize: Dimension.movieInfoAppBarTextFontSize,
              ),
            ),
            background: BackdropImage(
              movie: widget.movie,
            ),
          ),
        ),
        SliverFillRemaining(
          child: Center(
            child: Column(
              children: [
                BackDropRating(
                  movie: widget.movie,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: Dimension.movieInfoPaddingBottom,
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _customScrollView(),
    );
  }
}
