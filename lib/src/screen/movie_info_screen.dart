import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/genres_bloc.dart';
import '../styles/dimensions.dart';
import '../models/result_model.dart';
import '../widgets/backdrop_image.dart';
import '../widgets/movie_overview.dart';
import '../widgets/backdrop_rating.dart';
import '../widgets/staggered_grid_builder.dart';

class MovieInfo extends StatefulWidget {
  final Result movie;

  MovieInfo({
    Key key,
    this.movie,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  bool _isCollapsed = false;
  ScrollController _scrollController;

  bool get _isSliverAppBarExpanded =>
      _scrollController.hasClients && _scrollController.offset > (Dimension.movieInfoAppBarHeight - kToolbarHeight);

  @override
  void initState() {
    super.initState();
    Provider.of<GenresBloc>(context, listen: false).fetchAllGenres();

    _scrollController = ScrollController()
      ..addListener(
        () {
          _isCollapsed = _isSliverAppBarExpanded;
          setState(() {});
        },
      );
  }

  Widget _customScrollView() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          expandedHeight: Dimension.movieInfoAppBarHeight,
          floating: false,
          pinned: true,
          automaticallyImplyLeading: false,
          leading: Container(
            decoration: _isCollapsed == true
                ? BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    shape: BoxShape.circle,
                  )
                : BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade700.withOpacity(Dimension.movieSliverLeadingOpacity),
                      width: Dimension.movieSliverLeadingWidth,
                    ),
                    shape: BoxShape.circle,
                  ),
            margin: const EdgeInsets.only(
              left: Dimension.movieSliverLeadingLeftEdgeInsets,
            ),
            child: IconButton(
              color: _isCollapsed ? Colors.blue.shade300 : Colors.grey.shade700,
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Opacity(
              opacity: _isCollapsed == true ? 1 : 0,
              child: Text(
                '${widget.movie.originalTitle}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimension.movieInfoAppBarTextFontSize,
                ),
              ),
            ),
            background: BackdropImage(
              movie: widget.movie,
            ),
          ),
        ),
        SliverFillRemaining(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                      stream: Provider.of<GenresBloc>(context).allGenres,
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
