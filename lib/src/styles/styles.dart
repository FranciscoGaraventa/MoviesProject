import 'package:flutter/cupertino.dart';
import 'dimensions.dart';

final linearGradient = LinearGradient(
  colors: <Color>[
    Color(Dimension.searchScreenColor1),
    Color(Dimension.searchScreenColor2),
  ],
).createShader(Rect.fromLTWH(
  Dimension.searchScreenRectLT,
  Dimension.searchScreenRectLT,
  Dimension.searchScreenRectWidth,
  Dimension.searchScreenRectHeight,
));
