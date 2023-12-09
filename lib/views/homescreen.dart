import 'package:flutter/material.dart';
import 'package:mp5/models/newsnotifier.dart';
import 'package:mp5/models/savedsearch.dart';
import 'package:mp5/views/editsavedsearch.dart';
import 'package:mp5/views/searchresult.dart';

class HomeScreen extends StatelessWidget {

  final List<SavedSearch?> savedsearch;
  
  const HomeScreen({super.key, required this.savedsearch});
  
  @override
  Widget build(BuildContext context) {
    var icons = {
      'business_sharp': Icons.business_sharp,
      'laptop': Icons.laptop, 
      'book': Icons.book,
      'save': Icons.save,
      'news': Icons.newspaper
    };
    NewsNotifier notifier = NewsNotifier();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Finger Tip News"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.search),
          onPressed: () {
            String search = '';
            showDialog(
              context: context, 
              builder: (context)=>AlertDialog(
                title: const Text('Search'),
                content: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: TextFormField(
                    initialValue: search,
                    decoration: const InputDecoration(hintText: 'Search'),
                    onChanged: (value) => search = value,
                  ),
                ),
                actions: [
                  TextButton(onPressed: () { 
                    if(search!=''){
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return SearchResult(savedsearch: savedsearch,notifier: notifier, search: search,);
                          }
                        ),
                      );
                    }
                  }, child: Text('search'))
                ],
              ));
            print('search button clicked');
          }, 
        ),
      body: ListenableBuilder(listenable: notifier, builder: (BuildContext context, Widget? child){
        return Center(
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children : savedsearch.map((e) => ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  leading: Icon(icons[e!.icon]),
                  title: Text(e.title),
                  trailing: e.icon != 'news' ? Tooltip(
                              message: 'Default Search',
                              child: IconButton(icon: const Icon(Icons.info), onPressed: () {  },),
                            ) : IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return EditSavedSearch(savedItem: e,onPressDelete: () {
                                        savedsearch.remove(e);
                                        notifier.refreshSearchList();
                                      },onPressSave: (){
                                        notifier.refreshSearchList();
                                      },);
                                    }
                                  ),
                                );
                                print('press edit');
                              },
                            ),
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return SearchResult(notifier: notifier,search: e.title,);
                        }
                      ),
                    );
                    print('Business News tap');
                  },
                )).toList(),
            ),
          );
      }) 
    );
  }
}