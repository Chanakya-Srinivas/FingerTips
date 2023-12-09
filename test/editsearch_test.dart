import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/newsnotifier.dart';
import 'package:mp5/models/savedsearch.dart';
import 'package:mp5/views/editsavedsearch.dart';
import 'package:provider/provider.dart';

late List<SavedSearch> searchList;

Widget createEditScreen() => ChangeNotifierProvider<NewsNotifier>(
      create: (context) => NewsNotifier(),
      child: MaterialApp(
        home: EditSavedSearch(savedItem: SavedSearch(id: 100, title: 'News App',icon: 'News'),onPressDelete: (){print('Hi');}),
      ),
    );



void main() {
  group('Edit Page Widget Tests', () {

      testWidgets('Testing IconButtons', (tester) async {
        await tester.pumpWidget(createEditScreen());
        expect(find.text('News App'), findsOneWidget);
        expect(find.text('Delete'), findsOneWidget);
        await tester.tap(find.text('Delete'));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('News App Deleted'), findsNothing);
      });
  });

}