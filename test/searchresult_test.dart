import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/newsnotifier.dart';
import 'package:mp5/models/savedsearch.dart';
import 'package:mp5/views/searchresult.dart';
import 'package:provider/provider.dart';

late List<SavedSearch> searchList;

Widget createCardViewScreen() => ChangeNotifierProvider<NewsNotifier>(
      create: (context) => NewsNotifier(),
      child: MaterialApp(
        home: SearchResult(notifier: NewsNotifier(), search: 'china',savedsearch: [
          SavedSearch(title: 'china',icon: 'news',id: 123),
        ],),
      ),
    );



void main() {
  group('Edit Page Widget Tests', () {

      testWidgets('Testing IconButtons', (tester) async {
        await tester.pumpWidget(createCardViewScreen());
        expect(find.text('${'a'.toUpperCase()}uthor:'), findsOneWidget);
        expect(find.text('${'s'.toUpperCase()}ource:'), findsOneWidget);
        expect(find.text('${'c'.toUpperCase()}ontent:'), findsOneWidget);
        expect(find.text('${'d'.toUpperCase()}escription:'), findsOneWidget);
      });
  });

}