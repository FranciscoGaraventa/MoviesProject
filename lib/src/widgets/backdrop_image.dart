import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/imageNoAvailable.svg',
                      fit: BoxFit.cover,
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
