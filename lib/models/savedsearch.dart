import 'package:mp5/utils/db_helper.dart';

class SavedSearch {
  int? id;
  String title;
  String? icon;

  SavedSearch({this.id, required this.title,this.icon});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
    };
  }

  factory SavedSearch.fromMap(Map<String, dynamic> map) {
    return SavedSearch(
      id: map['id'],
      title: map['title'],
      icon: map['icon'],
    );
  }

  Future<void> dbSave() async {
    id = await DBHelper().insert('savedsearch', {
      'title': title,
      'icon': icon
    });
  }

  Future<void> dbUpdate() async {
    await DBHelper().update('savedsearch', {
      'id': id,
      'title': title,
    });
  }
}
