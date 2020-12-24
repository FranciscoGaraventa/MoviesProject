import 'package:flutter/material.dart';

class MockGenres extends StatelessWidget {
  final List<String> entries = <String>[
    'Action',
    'Adventure',
    'Animation',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'History',
    'Horror',
    'Music',
    'Mistery',
    'Romance',
    'Science Fiction',
    'TV Movie',
    'Thriller',
    'War',
    'Western',
  ];

  Widget _buildContent() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 30,
            child: Center(child: Text('${entries[index]}')),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }
}
