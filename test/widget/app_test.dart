import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_scat/util/quote.dart';
import 'package:pocket_scat/util/quote_source.dart';
import 'package:pocket_scat/widget/app.dart';

const PIECE_OF_YOUR_BRAIN = Quote(
    'fawlty_piece_of_your_brain', 'Piece of your brain', SRC_FAWLTY_TOWERS, 'Is this a piece of your brain Basil');
const ERRONEOUS_DISH =
    Quote('fawlty_erroneous_dish', 'Erroneous dish', SRC_FAWLTY_TOWERS, 'I have been given an erroneous dish');
const VERY_NICE_BRIAN = Quote('bean_very_nice_brian', 'Very nice Brian', SRC_BEAN, 'very nice brian');
const BAD_MISS = Quote('mitchell_bad_miss_1', 'Bad Miss 1', SRC_MITCHELL_AND_WEBB, 'Oh and thats a bad miss');

const TEST_QUOTES = [PIECE_OF_YOUR_BRAIN, ERRONEOUS_DISH, VERY_NICE_BRIAN, BAD_MISS];

void main() {
  testWidgets('Should search quotes, and clear the search when cancelled', (WidgetTester tester) async {
    await tester.pumpWidget(const App(TEST_QUOTES));

    expect(find.text('Erroneous dish'), findsOneWidget);
    expect(find.text('Piece of your brain'), findsOneWidget);

    // Tap the search icon and enter text
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'piece');
    await tester.pump();

    // Verify that our search has been applied
    expect(find.text('Erroneous dish'), findsNothing);
    expect(find.text('Piece of your brain'), findsOneWidget);

    // Close the search
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();

    // Search should be cancelled
    expect(find.text('Erroneous dish'), findsOneWidget);
    expect(find.text('Piece of your brain'), findsOneWidget);
  });
}
