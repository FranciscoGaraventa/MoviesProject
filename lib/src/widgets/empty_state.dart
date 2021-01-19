import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../styles/dimensions.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String text;

  EmptyState({this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null
              ? IconButton(
                  icon: Icon(icon),
                  iconSize: Dimension.iconSearchTypeSize,
                )
              : Image.asset(
                  'assets/images/moviesNoAvailable.png',
                  fit: BoxFit.contain,
                ),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.grey.shade700),
              children: [
                TextSpan(
                  text: text,
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
