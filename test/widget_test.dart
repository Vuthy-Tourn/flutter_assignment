import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_product_detail_app/main.dart';

void main() {
  testWidgets('renders product detail content', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Ready to Wear Downy Cheek'), findsOneWidget);
    expect(find.text('Select Color'), findsOneWidget);
    expect(find.text('You may also like'), findsOneWidget);
    expect(find.text('Review(3)'), findsWidgets);
  });
}
