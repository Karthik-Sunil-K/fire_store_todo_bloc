import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class DB {
  final db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> init() {
    return db.collection('CRUD').snapshots();
  }

  Future<String> createData(String? name) async {
    DocumentReference ref = await db
        .collection('CRUD')
        .add({'name': '$name 😎', 'todo': randomTodo()});
    print(ref.id);
    return ref.id;
  }

  void readData(String? id) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection('CRUD').doc(id).get();
    print(snapshot.data()!['name']);
  }

  void updateData(DocumentSnapshot doc) async {
    await db.collection('CRUD').doc(doc.id).update({'todo': 'please 🤫'});
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('CRUD').doc(doc.id).delete();
  }

  // Should not be inside here but probably inside a todoObject
  String randomTodo() {
    final randomNumber = Random().nextInt(4);
    String todo;
    switch (randomNumber) {
      case 1:
        todo = 'heloo';
        break;
      case 2:
        todo = 'Twitter @karthiksunil';
        break;
      case 3:
        todo = 'description';
        break;
      default:
        todo = 'type something';
        break;
    }
    return todo;
  }
}

DB db = DB();
