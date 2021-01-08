import 'package:flutter/material.dart';
import '../styles/dimensions.dart';
import '../models/result_model.dart';

class BackDropRating extends StatelessWidget {
  final Result movie;

  BackDropRating({
    Key key,
    this.movie,
  }) : super(key: key);

  Widget _buildContent(BuildContext context) {
    return Container(
      height: Dimension.ratingContainerHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(
              Dimension.ratingBoxShadowDx,
              Dimension.ratingBoxShadowDy,
            ),
            blurRadius: Dimension.ratingBoxShadowBlur,
            color: Color(
              Dimension.ratingBoxShadowColor,
            ).withOpacity(
              Dimension.ratingBoxShadowOpacity,
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
                          fontSize: Dimension.ratingVoteFontSize,
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: '10',
                      style: TextStyle(
                          fontSize: Dimension.ratingVoteFontSize,
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
                        fontSize: Dimension.ratingRichTextFontSize,
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
                        fontSize: Dimension.ratingRichTextFontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }
}
