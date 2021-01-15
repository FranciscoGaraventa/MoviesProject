import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/styles/dimensions.dart';
import '../models/result_model.dart';

class BackdropImage extends StatelessWidget {
  final Result movie;

  BackdropImage({
    Key key,
    this.movie,
  }) : super(key: key);

  Widget _buildContent() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Hero(
              tag: movie.id,
              child: movie.backdropPath != null
                  ? Image.network(
                      movie.backdropPath,
                      fit: BoxFit.fill,
                      height: Dimension.movieInfoAppBarHeight + 50,
                    )
                  : Image.asset(
                      'assets/images/imageNoAvailable.svg',
                      fit: BoxFit.contain,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }
}
