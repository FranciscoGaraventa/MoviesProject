import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/screen/movies_search.dart';
import 'package:movies_widgets_package/movies_widgets_package.dart';

void main() {
  Widget _buildWidget() {
    return MaterialApp(
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          body: Center(
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                showSearch(
                  context: context,
                  delegate: CustomMoviesSearch('Search movies...'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('Testing initial state when user tap on search icon', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget());
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    expect(find.byType(MovieEventInitial), findsOneWidget);
  });
}
