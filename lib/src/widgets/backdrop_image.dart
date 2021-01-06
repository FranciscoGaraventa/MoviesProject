import 'package:flutter/cupertino.dart';
import '../styles/dimensions.dart';
import '../models/result_model.dart';
import 'backdrop_rating.dart';

class BackdropImage extends StatelessWidget {
  final Size size;
  final Result movie;

  BackdropImage({
    Key key,
    this.size,
    this.movie,
  }) : super(key: key);

  Widget _buildContent() {
    return Container(
      height: size.height * Dimension.backImagePercentage,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height * Dimension.backImagePercentage -
                Dimension.backImageLessX,
            width: double.infinity,
            child: Hero(
              tag: movie.id,
              child: Image.network(
                movie.backdropPath,
              ),
            ),
          ),
          BackDropRating(
            size: size,
            movie: movie,
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
