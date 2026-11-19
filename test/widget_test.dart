import 'package:flutter_test/flutter_test.dart';
import 'package:pathfolio/main.dart';

void main() {
  testWidgets('Welcome screen shows the main buttons', (tester) async {
    await tester.pumpWidget(const PathFolioApp());
    await tester.pump();

    expect(find.text('Sign up'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
    expect(find.text('Continue as guest'), findsOneWidget);
  });
}
