import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:arahin_workshop_mini/main.dart';

void main() {
  testWidgets('shows login form and switches to registration', (tester) async {
    await tester.pumpWidget(const WorkshopApp());

    expect(find.text('Selamat datang!'), findsOneWidget);
    expect(find.byKey(const Key('email-field')), findsOneWidget);
    expect(find.byKey(const Key('password-field')), findsOneWidget);

    await tester.tap(find.text('Belum punya akun? Daftar'));
    await tester.pumpAndSettle();

    expect(find.text('Buat akun'), findsOneWidget);
    expect(find.byKey(const Key('name-field')), findsOneWidget);
  });
}
