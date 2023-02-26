import 'package:cloud_firestore/cloud_firestore.dart';

class ApartmentData {
  final DocumentSnapshot documentSnapshot;
  final int price;
  final String people;
  final Duration days;

  ApartmentData(this.documentSnapshot, this.price, this.people, this.days, );
}
