import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("geeksforgeeks"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('test').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            print(snapshot.hasData);
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Center(child: Text(document['name']));
            }).toList(),
          );
        },
      ),
    );
  }
}
