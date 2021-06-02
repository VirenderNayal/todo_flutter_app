import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference todos = FirebaseFirestore.instance.collection('todos');

    return new AlertDialog(
      title: Text("Add a Note."),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: myController,
              decoration: InputDecoration(
                labelText: "What you need to remember.",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            ElevatedButton(
              onPressed: () {
                todos
                    .add({
                      'todo': myController.text,
                      'timestamp': FieldValue.serverTimestamp(),
                    })
                    .then((value) => print("User Added"))
                    .catchError((error) => print("Failed to add user: $error"));
                setState(() {
                  myController.text = "";
                });
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
