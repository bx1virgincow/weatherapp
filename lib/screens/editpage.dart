import 'package:flutter/material.dart';
import 'package:weatherapp/model/tasks.dart';

class EditPage extends StatelessWidget {
  final Task task;
  const EditPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
    );
  }
}
