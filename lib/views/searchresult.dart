import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mp5/models/newsnotifier.dart';
import 'package:mp5/models/savedsearch.dart';
import 'package:http/http.dart' as http;

class SearchResult extends StatefulWidget{

  final NewsNotifier notifier;
  final List<SavedSearch?>? savedsearch;
  final String search;

  const SearchResult({super.key, required this.notifier, this.savedsearch, required this.search});

  @override
  State createState() => _SearchResult();
}

class _SearchResult extends State<SearchResult> {
  Future<List<dynamic>>? futureArticles;
  String baseUrl = 'https://newsapi.org/v2/';
  int index = 0;
  final String  API_KEY = 'a036457c64a74e56b1efc14ad30260f5';

  @override
  void initState() {
    super.initState();
    futureArticles = _loadarticles();
  }

  void _changeIndex(int i){
    setState(() {
      index += i;  
    });
  }

  Future<List<dynamic>> _loadarticles() async {
    String url = baseUrl;
    if(widget.search == 'Business News'){
      url += 'top-headlines?country=us&category=business';
    } else {
      url += 'everything?';
      if(widget.search == 'Wall Street Journal'){
        url += 'domains=wsj.com';
      } else {
        url += 'q=${widget.search}&sortBy=publishedAt';
      }
    }
    final response = await http.get(Uri.parse('$url&apiKey=$API_KEY'),headers: {'Access-Control-Allow-Origin' : '*'});
    final articles = json.decode(response.body);
    return articles['articles'];
  }
  
  @override
  Widget build(BuildContext context) {
    List details = ['author', 'source', 'publishedAt', 'description', 'content', 'url'];
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed: (){
              if(widget.savedsearch==null || widget.savedsearch!.map((e) => e!.title,).where((element) => element==widget.search).toList().isNotEmpty){
                Navigator.pop(context, false);
              } else {
                showDialog(context: context, 
                builder: (context)=>AlertDialog(
                  content: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text('Do you want save ${widget.search} search?'),
                  ),
                  actions: [
                    TextButton(onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context, false);
                        SavedSearch temp = SavedSearch(title: widget.search,icon: 'news');
                        temp.dbSave();
                        widget.savedsearch!.add(temp);
                        widget.notifier.refreshSearchList();
                    }, child: const Text('Yes')),
                    TextButton(onPressed: () { 
                        Navigator.pop(context);
                        Navigator.pop(context, false);
                    }, child: const Text('No'))
                  ],
                ));
              }
            },
          ),
        backgroundColor: Colors.blue,
        title: Text("${widget.search} News"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureArticles,
        initialData: const [],
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
          var snapFilter = snapshot.data!.where((element) => element['description']!=null || element['content']!=null).toList();
          return ListenableBuilder(listenable: widget.notifier,builder: (BuildContext context, Widget? child){
            return snapFilter.isEmpty ? Center(child: CircularProgressIndicator(),) : ListView(
              children: [
                ListTile(
                  titleAlignment: ListTileTitleAlignment.top,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios), onPressed: index==0 ? null : () { _changeIndex(-1); },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios), onPressed: index==snapFilter.length-1 ? null : () { _changeIndex(1); },
                  ),
                  title: Text(snapFilter[index]['title'].toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                  Column(
                    children: List.generate(details.length, (i) {
                      return ListTile(
                        titleAlignment: ListTileTitleAlignment.top,
                        leading: Text(details[i][0].toUpperCase() + details[i].substring(1) +":",style: TextStyle(fontSize: 20),),
                        title: Text(i==1 ? 
                        snapFilter[index][details[i]]['name'] :
                        snapFilter[index][details[i]]==null ? 'Unkown' : snapFilter[index][details[i]]),
                      );
                    }),
                  )
              ],
            );
          });
          // return ListView.builder(
              // itemCount: snapFilter.length,
              // itemBuilder: (context, index) {
              //   return ListTile(
              //     titleAlignment: ListTileTitleAlignment.center,
              //     title: Text(snapFilter[index]['title']),
              //     onTap: () {
              //       print('${snapFilter[index]['title']} tap');
              //     },
              //   );
              // });
          }
        }),
    );
  }
}