import 'package:flutter/material.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/model/items.dart';
import 'package:myapp/screens/result.dart';
import 'package:myapp/screens/sidebar.dart';
import 'package:myapp/controller/history_storage.dart';
import 'package:myapp/controller/base64_conver.dart';

// late HistoryStorage storage;

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<HistoryItem> items = readHistory() as List<HistoryItem>;

    return Scaffold(
        drawer: const Sidebar(),
        appBar: AppBar(
          title: const Text('History'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<HistoryItem>>(
              future: readHistory(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  return Center(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shadowColor: Colors.grey,
                          elevation: 10,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                          child: Container(
                            height: 70,
                            child: ListTile(
                              leading: Image.memory(
                                dataFromBase64String(snapshot
                                    .data[snapshot.data.length - index - 1]!
                                    .image),
                                width: 80,
                                height: 80,
                              ),
                              title: Text(snapshot
                                  .data[snapshot.data.length - index - 1]!
                                  .name),
                              subtitle: Text(snapshot
                                  .data[snapshot.data.length - index - 1]!
                                  .created),
                              trailing: const Icon(Icons.arrow_right),
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => Result(
                                //             item: items[index],
                                //           )),
                                // );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return Container();
              }),
        ));
  }
}
