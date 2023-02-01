import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GetHotel extends ChangeNotifier{
  CollectionReference hotel = FirebaseFirestore.instance.collection('hotels');
}