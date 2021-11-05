import 'package:flutter/material.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/model/items.dart';
import 'package:myapp/screens/sidebar.dart';
import 'package:myapp/controller/history_storage.dart';
import 'package:myapp/controller/base64_conver.dart';
import 'package:myapp/screens/result.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        drawer: const Sidebar(),
        appBar: AppBar(
          title: const Text('History'),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
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
                          shadowColor: Colors.black,
                          elevation: 4,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2)),
                          child: SizedBox(
                            height: 70,
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  dataFromBase64String(snapshot
                                      .data[snapshot.data.length - index - 1]!
                                      .image),
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              title: Text(
                                  snapshot
                                      .data[snapshot.data.length - index - 1]!
                                      .name,
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(snapshot
                                  .data[snapshot.data.length - index - 1]!
                                  .created),
                              trailing: const Icon(Icons.arrow_right),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Result(
                                      item: snapshot.data[
                                          snapshot.data.length - index - 1],
                                    ),
                                  ),
                                );
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
