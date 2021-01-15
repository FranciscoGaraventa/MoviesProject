import 'package:flutter/material.dart';
import '../styles/dimensions.dart';

class InitialState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.search),
            iconSize: Dimension.iconSearchTypeSize,
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.grey.shade700),
              children: [
                TextSpan(
                  text: 'ENTER A MOVIE NAME TO START SEARCH',
                  style: TextStyle(fontSize: Dimension.searchEventTextFontSize, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
