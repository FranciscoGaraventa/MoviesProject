import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../styles/dimensions.dart';
import '../models/item_model.dart';
import 'card_grid.dart';

class MovieList extends StatelessWidget {
  final ItemModel resultData;
  final int crossAxisCount;

  const MovieList({
    Key key,
    this.resultData,
    this.crossAxisCount = Dimension.movieListAxisCount,
  }) : super(key: key);

  Widget _buildContent() {
    return GridView.builder(
      itemCount: resultData.results.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount),
      itemBuilder: (BuildContext context, int index) {
        return CardGrid(
          movieResult: resultData.results[index],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }
}
