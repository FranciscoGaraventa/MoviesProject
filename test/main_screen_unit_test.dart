import 'package:flutter/material.dart';
import 'package:movies_app/src/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('Correct display of elements in Main Screen', (WidgetTester tester) async {
    await tester.runAsync(() async => {await mockNetworkImagesFor(() => tester.pumpWidget(MyApp()))});
    expect(find.byKey(ValueKey('TitleRow')), findsOneWidget);
    expect(find.byKey(ValueKey('iconButtonSearch')), findsOneWidget);
  });
}
