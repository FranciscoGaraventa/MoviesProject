import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../styles/dimensions.dart';
import '../models/genre_model.dart';
import '../models/genre_result_model.dart';
import '../models/result_model.dart';
import 'genre_card.dart';

String _getGenreName(GenreModel data, int id) {
  for (GenreResult gr in data.genres) {
    if (gr.id == id) return gr.name;
  }
  return "";
}

class StaggeredGridBuilder extends StatelessWidget {
  final GenreModel resultData;
  final Result movie;
  final int crossAxisCount;

  const StaggeredGridBuilder({
    Key key,
    this.resultData,
    this.movie,
    this.crossAxisCount = Dimension.crossAxisCount,
  }) : super(key: key);

  Widget _buildContent(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: movie.genreIds.length < crossAxisCount ? movie.genreIds.length : crossAxisCount,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: movie.genreIds.length,
      itemBuilder: (BuildContext context, int index) => GenreCard(
        genre: _getGenreName(resultData, movie.genreIds[index]),
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(Dimension.staggeredTileFit),
      mainAxisSpacing: Dimension.staggeredTileMainAxisSpacing,
      crossAxisSpacing: Dimension.staggeredTileCrossAxisSpacing,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }
}

