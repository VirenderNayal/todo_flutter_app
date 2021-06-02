import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/addNote.dart';
import 'package:todo_app/screens/todoItem.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context, builder: (BuildContext context) => AddNote());
        },
        child: Icon(
          CupertinoIcons.add,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "Todo ~ App",
                textScaleFactor: 3,
                style: TextStyle(
                    fontWeight: FontWeight.w300, fontFamily: "Popins"),
              ),
              SizedBox(height: 50),
              // List of todos
              Expanded(child: TodoItem()),
            ],
          ),
        ),
      ),
    );
  }
}
