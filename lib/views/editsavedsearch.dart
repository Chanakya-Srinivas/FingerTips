import 'package:flutter/material.dart';
import 'package:mp5/models/savedsearch.dart';
import 'package:mp5/utils/db_helper.dart';

class EditSavedSearch extends StatelessWidget{

  final SavedSearch savedItem;
  final VoidCallback? onPressDelete;
  final VoidCallback? onPressSave;

  const EditSavedSearch({super.key, required this.savedItem, this.onPressDelete, this.onPressSave});

  @override
  Widget build(BuildContext context) {
    String search = savedItem.title;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Saved Search'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextFormField(
                initialValue: search,
                decoration: const InputDecoration(hintText: 'Search Name'),
                onChanged: (value) => search = value,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    child: const Text('Save'),
                    onPressed: () async {
                      if(search==''){
                        showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.of(context).pop(true);
                            });
                            return const AlertDialog(
                              content: Padding(
                                  padding: EdgeInsets.all(24.0),
                                  child: Text('Fields can not be empty'),
                              ) ,
                            );
                          });
                      } else{
                        savedItem.title = search;
                        await savedItem.dbUpdate();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${savedItem.title} updated'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                        Navigator.of(context).pop(savedItem);
                        onPressSave!();
                      }
                    },
                  ),
                TextButton(
                    child: const Text('Delete'),
                    onPressed: () async {
                      await DBHelper().delete('savedsearch', savedItem.id!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${savedItem.title} deleted'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                      Navigator.of(context).pop(savedItem);
                      onPressDelete!();
                    },
                  ),
              ],
            ),
          ],
        )
      ),
    );
  }

}