import 'package:flutter_test/flutter_test.dart';
import 'package:bigbull/main.dart';

void main() {
  testWidgets('Home shows Bigbull sections', (tester) async {
    await tester.pumpWidget(const BigbullApp());
    expect(find.text('Continue learning'), findsOneWidget);
    expect(find.text('Recommended'), findsOneWidget);
  });
}
