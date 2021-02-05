import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/bloc/genres_bloc.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:movies_app/src/screen/movie_info_screen.dart';
import 'package:movies_widgets_package/movies_widgets_package.dart';

void main() {
  Widget _buildWidget() {
    return MaterialApp(
      home: Scaffold(
        body: MovieInfo(
          movie: Movie(
            id: 508442,
            originalLanguage: "en",
            title: "Soul",
            backdropPath: "/kf456ZqeC45XTvo6W9pW5clYKfQ.jpg",
            originalTitle: "Soul",
            releaseDate: "2020-12-25",
            voteAverage: 8.3,
            genreIds: [10751, 16, 35, 18, 10402, 14],
            overview:
                "Joe Gardner is a middle school teacher with a love for jazz music. After a successful gig at the Half Note Club, he suddenly gets into an accident that separates his soul from his body and is transported to the You Seminar, a center in which souls develop and gain passions before being transported to a newborn child. Joe must enlist help from the other souls-in-training, like 22, a soul who has spent eons in the You Seminar, in order to get back to Earth.",
          ),
        ),
      ),
    );
  }

  Widget build() {
    return MultiProvider(providers: [
      Provider(
        create: (_) => GenresBloc(),
      ),
    ], child: _buildWidget());
  }

  group('Movie info screen test', () {
    testWidgets('Correct display of elements in Movie info screen', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(build()));
      await tester.pump(Duration.zero);
      expect(find.byType(MovieBackdropImage), findsOneWidget);
      expect(find.byType(RatingReleaseLang), findsOneWidget);
      expect(find.byType(MovieOverview), findsOneWidget);
      expect(find.byType(GenresGridView), findsOneWidget);
    });

    testWidgets('Testing sliver app bar functionality', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(build()));
      await tester.pump(Duration.zero);
      expect(find.byType(SliverAppBar), findsOneWidget);
      expect(find.byType(MovieBackdropImage), findsOneWidget);
      final gesture = await tester.startGesture(Offset(0, 300));
      await gesture.moveBy(Offset(0, -300));
      await tester.pump();
      expect(find.byKey(ValueKey('CollapsedIcon')), findsOneWidget);
      expect(find.byKey(ValueKey('CollapsedText')), findsOneWidget);
      await gesture.moveBy(Offset(0, 300));
      await tester.pump();
      expect(find.byType(MovieBackdropImage), findsOneWidget);
    });
  });
}
