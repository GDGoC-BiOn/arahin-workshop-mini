import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:arahin_workshop_mini/main.dart';

void main() {
  testWidgets('shows login form and switches to registration', (tester) async {
    await tester.pumpWidget(const WorkshopApp());

    expect(find.text('Masuk ke akun Arahin\nkamu'), findsOneWidget);
    expect(find.byKey(const Key('email-field')), findsOneWidget);
    expect(find.byKey(const Key('password-field')), findsOneWidget);

    final switchModeButton = find.text('Belum punya akun? Daftar');
    await tester.ensureVisible(switchModeButton);
    await tester.tap(switchModeButton);
    await tester.pumpAndSettle();

    expect(find.text('Daftar Arahin secara\nSimple'), findsOneWidget);
    expect(find.byKey(const Key('name-field')), findsOneWidget);
  });
}
