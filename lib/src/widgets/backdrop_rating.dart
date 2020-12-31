import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../styles/dimensions.dart';
import '../models/result_model.dart';

class BackDropRating extends StatelessWidget {
  final Size size;
  final Result movie;

  BackDropRating({
    Key key,
    this.size,
    this.movie,
  }) : super(key: key);

  Widget _buildContent(BuildContext context) {
    return Positioned(
      bottom: Dimension.RatingPosition,
      right: Dimension.RatingPosition,
      child: Container(
        height: Dimension.RatingContainerHeight,
        width: size.width * Dimension.RatingPercentage,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dimension.RatingBottomAndLeftRadius),
            topLeft: Radius.circular(Dimension.RatingBottomAndLeftRadius),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(
                Dimension.RatingBoxShadowDx,
                Dimension.RatingBoxShadowDy,
              ),
              blurRadius: Dimension.RatingBoxShadowBlur,
              color: Color(
                Dimension.RatingBoxShadowColor,
              ).withOpacity(
                Dimension.RatingBoxShadowOpacity,
              ),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: '${movie.voteAverage}/',
                        style: TextStyle(
                            fontSize: Dimension.RatingVoteFontSize,
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: '10',
                        style: TextStyle(
                            fontSize: Dimension.RatingVoteFontSize,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('LANGUAGE'),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: '${movie.originalLanguage.toUpperCase()}',
                        style: TextStyle(
                          fontSize: Dimension.RatingRichTextFontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('RELEASE DATE'),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: '${movie.releaseDate}',
                          style: TextStyle(
                            fontSize: Dimension.RatingRichTextFontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }
}
