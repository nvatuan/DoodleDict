import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/screens/items.dart';
import 'package:myapp/screens/sidebar.dart';

final df = new DateFormat('dd-MM-yyyy hh:mm:ss a');

HistoryItem item1 = HistoryItem('apple', 'apple_1', DateTime.now());
HistoryItem item2 = HistoryItem('dog', 'dog_1', DateTime.now());
HistoryItem item3 = HistoryItem('cat', 'cat_1', DateTime.now());
List<HistoryItem> items = List.from([item1, item2, item3]);

class History extends StatelessWidget {
  History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Sidebar(),
        appBar: AppBar(
          title: const Text('History'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  shadowColor: Colors.grey,
                  elevation: 10,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: Colors.blue, width: 1)),
                  child: Container(
                    height: 70,
                    child: ListTile(
                        leading: Image.asset(
                          '${items[index].name}_1.jpg',
                          width: 80,
                          height: 80,
                        ),
                        title: Text(items[index].name),
                        subtitle:
                            Text(df.format(items[index].created).toString()),
                        trailing: Icon(Icons.arrow_right),
                        onTap: () => print("ListTile")),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
