import 'package:flutter/material.dart';
import 'package:mp5/models/savedsearch.dart';
import 'package:mp5/views/homescreen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searches = Provider.of<List<SavedSearch?>>(context);
    if(searches.isEmpty){
      return const Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: CircleAvatar(
                  radius: 48, // Image radius
                  backgroundImage: AssetImage('assets/NewsIcon.png'),
                )
        ),
      );
    } else {
      return HomeScreen(savedsearch: searches,);
    }
    
  }
}