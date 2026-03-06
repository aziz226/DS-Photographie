import 'package:flutter_test/flutter_test.dart';
import 'package:ds_photographie/main.dart';

void main() {
  testWidgets('App loads', (WidgetTester tester) async {
    await tester.pumpWidget(const DSPhotographieApp());
    expect(find.text('SCROLL'), findsOneWidget);
  });
}
