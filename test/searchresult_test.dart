import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/newsnotifier.dart';
import 'package:mp5/models/savedsearch.dart';
import 'package:mp5/views/homescreen.dart';
import 'package:provider/provider.dart';

late List<SavedSearch> searchList;

Widget createHomeScreen() => ChangeNotifierProvider<NewsNotifier>(
      create: (context) => NewsNotifier(),
      child: MaterialApp(
        home: HomeScreen(savedsearch: List.generate(20, (index) => SavedSearch(title: 'News App$index',icon: index<1 ? 'laptop' :'news')),),
      ),
    );



void main() {
  group('Home Page Widget Tests', () {
    testWidgets('Testing if ListView shows up', (tester) async {  
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(ListView), findsOneWidget);
    });   

    testWidgets('Testing Scrolling', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.text('News App1',), findsOneWidget);
      await tester.fling(
        find.byType(ListView),
        const Offset(0, -200),
        3000,
      );
      await tester.pumpAndSettle();
      expect(find.text('News App1'), findsNothing);
    });
  });

}
