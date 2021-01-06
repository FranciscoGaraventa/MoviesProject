import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/result_model.dart';
import '../styles/dimensions.dart';

class MovieOverview extends StatelessWidget {
  MovieOverview({
    Key key,
    this.movie,
  }) : super(key: key);

  final Result movie;

  Widget _buildContent() {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.blueGrey.shade200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'OVERVIEW',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimension.movieOverviewFontSize,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Container(
          color: Colors.blueGrey.shade100,
          child: Padding(
            padding: EdgeInsets.all(Dimension.movieOverviewPadding),
            child: Text(
              movie.overview,
              style: TextStyle(
                color: Colors.black,
                fontSize: Dimension.movieOverviewFontSize,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }
}
