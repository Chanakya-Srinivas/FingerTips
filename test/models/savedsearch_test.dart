import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/savedsearch.dart';

void main() {

  
  group('Testing saved search', () {

    test('A new search created', () async {
      var title = 'News App';
      final search = SavedSearch(title: title);
      expect(search.title == title, true);
    });    
  });
}
