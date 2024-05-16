import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghibloo_app/view/screen/home/home_screen.dart';
import 'package:ghibloo_app/view/widget/categories_widget.dart';
import 'package:ghibloo_app/view/widget/characters_categories_widget.dart';
import 'package:ghibloo_app/view/widget/film_categories_widget.dart';

void main() {
  testWidgets('HomeScreen UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomeScreen(),
    ));

    expect(find.byType(Image), findsOneWidget);

    expect(find.text('CATEGORIES'), findsOneWidget);

    expect(find.text('FILMS'), findsOneWidget);

    expect(find.text('CHARACTERS'), findsOneWidget);

    expect(find.widgetWithText(TextButton, 'View all'), findsOneWidget);

    expect(find.widgetWithText(TextButton, 'View all'), findsOneWidget);

    expect(find.byType(CategoriesWidget), findsOneWidget);

    expect(find.byType(FilmCategories), findsOneWidget);

    expect(find.byType(CharactersCategories), findsOneWidget);
  });
}
