import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/model/tasks.dart';
import 'package:weatherapp/screens/editpage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  //list of results
  List<Task> tasks = [];
  //making an api call to the backend to get tasks
  Future<List<Task>> getData() async {
    String endPoint = 'http://10.0.2.2:1234/task/gettask/';

    var response = await http.get(Uri.parse(endPoint));
    var jsonResponse = jsonDecode(response.body);

    setState(() {
      for (var element in jsonResponse) {
        Task task = Task.fromJson(element);
        tasks.add(task);
      }
    });
    return tasks;
  }

  //api call to delete tasks
  FutureOr<void> deleteTask(String id) async {
    String endPoint = 'http://10.0.2.2:1234/task/deletetask/$id';
    var response = await http.delete(Uri.parse(endPoint));
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Successfully Deleted',
          ),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to delete',
          ),
        ),
      );
    }
  }

  //run code on initState
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Flutter Tutorial'),
        actions: [
          GestureDetector(
            onTap: getData,
            child: const Icon((Icons.abc)),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 12,
        ),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (BuildContext context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                vertical: 4,
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.pink,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: const Icon(Icons.animation),
                title: Text(tasks.elementAt(index).title),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPage(
                                task: tasks.elementAt(index),
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.edit,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            deleteTask(tasks.elementAt(index).id);
                          });
                          getData();
                        },
                        child: const Icon(
                          Icons.delete,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 300,
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    children: [
                      //Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Add Task'),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.close,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),

                      //text fields
                      TextFormField(
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ],
                  ),
                );
              });
        },
        label: const Text('Add Task'),
      ),
    );
  }
}
