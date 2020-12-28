import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'card_grid.dart';

class GridBuilder extends StatelessWidget {
  final ItemModel resultData;

  const GridBuilder({
    Key key,
    this.resultData,
  }) : super(key: key);

  Widget _buildContent() {
    return GridView.builder(
      itemCount: resultData.results.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
