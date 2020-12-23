import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MockMovies extends StatelessWidget {
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N'
  ];
  final List<int> colorCodes = <int>[
    50,
    100,
    200,
    300,
    400,
    600,
    700,
    800,
    900
  ];

  Widget _buildContent() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.cyan[colorCodes[Random().nextInt(colorCodes.length)]],
            child: Center(child: Text('Trending Movie ${entries[index]}')),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }
}
