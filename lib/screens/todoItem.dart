import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoItem extends StatefulWidget {
  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  Widget _popupEdit(BuildContext context) {
    return new AlertDialog(
      content: Container(
        child: Text("This have to be edited"),
      ),
    );
  }

  final CollectionReference _todos =
      FirebaseFirestore.instance.collection("todos");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _todos.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Expanded(child: Center(child: CircularProgressIndicator()));
        }

        return new ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            return new ListTile(
              contentPadding: EdgeInsets.only(top: 12, bottom: 12),
              title: new Text(
                document.data()['todo'],
                textScaleFactor: 1.2,
                style: TextStyle(
                  fontFamily: "monospace",
                  fontWeight: FontWeight.w700,
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  CupertinoIcons.pencil_outline,
                  size: 30,
                  color: Colors.blue,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => _popupEdit(context));
                },
              ),
              trailing: IconButton(
                icon: Icon(
                  CupertinoIcons.delete_solid,
                  size: 25,
                  color: Colors.red,
                ),
                onPressed: () {
                  _todos
                      .doc(document.id)
                      .delete()
                      .then((value) => print("User Deleted"))
                      .catchError(
                          (error) => print("Failed to delete user: $error"));
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
