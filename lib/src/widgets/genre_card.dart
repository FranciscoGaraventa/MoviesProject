import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../styles/dimensions.dart';

class GenreCard extends StatelessWidget {
  final String genre;

  GenreCard({Key key, this.genre}) : super(key: key);

  Widget _buildContent() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(
          Dimension.genreCardBorderRadius,
        ),
      ),
      child: Text(
        '$genre',
        style: TextStyle(
          color: Colors.grey.withOpacity(
            Dimension.genreCardOpacity,
          ),
          fontSize: Dimension.genreCardFontSize,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }
}
