import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/events/search_event.dart';
import 'package:movies_app/src/widgets/search_events.dart';
import 'package:movies_widgets_package/movies_widgets_package.dart';

void main() {
  Widget _buildWidget(SearchEvent searchEvent) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: SearchStates(
            results: searchEvent,
          ),
        ),
      ),
    );
  }

  group('Testing search events state types [loading, empty, success, initial, error]', () {
    testWidgets('Check when state type is loading', (WidgetTester tester) async {
      await tester.pumpWidget(_buildWidget(SearchEvent(stateType: SearchStateType.loading)));

      expect(find.byKey(ValueKey('searchTypeLoading')), findsOneWidget);
    });

    testWidgets('Check when stage type is empty', (WidgetTester tester) async {
      await tester.pumpWidget(_buildWidget(SearchEvent(stateType: SearchStateType.empty)));

      expect(find.byType(MovieEventEmpty), findsOneWidget);
    });

    testWidgets('Check when stage type is error', (WidgetTester tester) async {
      await tester.pumpWidget(_buildWidget(SearchEvent(stateType: SearchStateType.error)));

      expect(find.byType(MovieEventError), findsOneWidget);
    });

    testWidgets('Check when stage type is initial', (WidgetTester tester) async {
      await tester.pumpWidget(_buildWidget(SearchEvent(stateType: SearchStateType.initial)));

      expect(find.byType(MovieEventInitial), findsOneWidget);
    });

    testWidgets('Check when stage type is success', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchStates(
              results: SearchEvent(
                movies: MovieModel(),
                stateType: SearchStateType.success,
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(ValueKey('stateTypeSuccessListView')), findsOneWidget);
    });
  });
}
