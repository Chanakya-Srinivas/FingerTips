
import 'package:flutter/material.dart';
import 'package:mp5/models/savedsearch.dart';
import 'package:mp5/utils/db_helper.dart';
import 'package:mp5/views/splashscreen.dart';
import 'package:provider/provider.dart';


class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  Future<List<SavedSearch>> _loadData(BuildContext context) async {

    // SavedSearch(title: 'Business News',icon: 'business_sharp').dbSave();
    // SavedSearch(title: 'Tech News',icon: 'laptop').dbSave();
    // SavedSearch(title: 'Wall Street Journal',icon: 'book').dbSave();
    // SavedSearch(title: 'Saved News',icon: 'save').dbSave();

    final savedsearchs= await DBHelper().query('savedsearch');
    await Future.delayed(const Duration(seconds: 3));
    return savedsearchs.isEmpty ? [] : savedsearchs.map((e) => SavedSearch(
          id: e['id'] as int,
          title: e['title'],
          icon: e['icon'])).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureProvider<List<SavedSearch?>>(
        create: (context) => _loadData(context),
        initialData: [],
        child: const SplashScreen(),
      ),
    );
  }
}




