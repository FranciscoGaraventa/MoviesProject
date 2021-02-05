import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/bloc/movies_bloc.dart';
import 'package:movies_app/src/widgets/movies_events.dart';
import 'package:movies_app/src/screen/movies_by_genre.dart';
import 'package:movies_app/src/bloc/connectivity_bloc.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:movies_widgets_package/movies_widgets_package.dart';

void main() {
  Widget _buildWidget() {
    return MaterialApp(
      home: Scaffold(
          body: MoviesByGenre(
        genre: Genre(
          id: 12,
          name: 'Adventure',
        ),
      )),
    );
  }

  Widget build() {
    return MultiProvider(providers: [
      Provider(
        create: (_) => MoviesBloc(),
      ),
      Provider(create: (_) => ConnectivityServiceBloc()),
    ], child: Builder(builder: (_) => _buildWidget()));
  }

  testWidgets('Correct display of elements in Movie by genre', (WidgetTester tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(build()));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.text('Adventure'), findsOneWidget);
    expect(find.byType(MoviesEvents), findsOneWidget);
  });
}
