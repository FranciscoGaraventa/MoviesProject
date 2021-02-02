import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_widgets_package/movies_widgets_package.dart';
import '../bloc/genres_bloc.dart';
import '../styles/dimensions.dart';
import '../models/genre_model.dart';
import '../models/genre_result.dart';

class MovieInfo extends StatefulWidget {
  final Movie movie;

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

  String _getGenreName(GenreModel data, int id) {
    for (GenreResult gr in data.genres) {
      if (gr.id == id) return gr.name;
    }
    return "";
  }

  List<String> _parseGenresToString(List<int> genreIds, GenreModel snapshot) {
    List<String> _genresList = [];
    for (int genreId in genreIds) {
      _genresList.add(_getGenreName(snapshot, genreId));
    }
    return _genresList;
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
              key: Key('CollapsedIcon'),
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
                widget.movie.originalTitle,
                key: Key('CollapsedText'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimension.movieInfoAppBarTextFontSize,
                ),
              ),
            ),
            background: MovieBackdropImage(
              movieId: widget.movie.id,
              backdropPath: widget.movie.backdropPath,
              defaultImageRoute: 'assets/images/imageNoAvailable.svg',
            ),
          ),
        ),
        SliverFillRemaining(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Column(
                children: [
                  RatingReleaseLang(
                    originalLanguage: widget.movie.originalLanguage,
                    releaseDate: widget.movie.releaseDate,
                    voteAverage: widget.movie.voteAverage,
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
                              child: GenresGridView(
                                genres: _parseGenresToString(widget.movie.genreIds, snapshot.data),
                              ));
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  MovieOverview(
                    overview: widget.movie.overview,
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
