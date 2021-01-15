import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../styles/routes.dart';
import '../models/result_model.dart';
import '../styles/dimensions.dart';

class CardGrid extends StatelessWidget {
  final Result movieResult;

  CardGrid({this.movieResult});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, movieInfo, arguments: movieResult);
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimension.cardBorderRadius)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimension.clipBorderRadius),
                  child: Hero(
                    tag: movieResult.id,
                    child: movieResult.backdropPath != null
                        ? Image.network(
                            movieResult.backdropPath,
                            fit: BoxFit.cover,
                          )
                        : Image.asset('assets/images/imageNoAvailable.svg'),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(Dimension.cardContainerEdgeInsets),
            child: Text(
              movieResult.title.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
