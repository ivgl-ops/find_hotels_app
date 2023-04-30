import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_hotels_app/widgets/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/apartmentsData.dart';

class PaymentConfirmationWidget extends StatefulWidget {
  const PaymentConfirmationWidget({Key? key}) : super(key: key);

  @override
  State<PaymentConfirmationWidget> createState() =>
      _PaymentConfirmationWidgetState();
}

class _PaymentConfirmationWidgetState extends State<PaymentConfirmationWidget> {

  void searchfromFirebase(var args) async {
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('hotels_ru')
          .doc(args.searchResult['id'])
          .get();
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data();
        if (kDebugMode) {
          print('Data for document ${args.searchResult['id']}: $data');
        }
      } else {
        if (kDebugMode) {
          print('Document with ID ${args.searchResult['id']} does not exist');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error getting document: $error');
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as ApartmentDataView;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 170,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 100,
              ),
            ),
          ),
          SizedBox(height: 20),
          CustomText(
            text: 'Оплата ${args.searchResult['name']} успешно подтверждена!',
            align: TextAlign.center,
            fontWeight: FontWeight.bold,
            size: 16,
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: CustomText(
              align: TextAlign.center,
              text:
                  'Вы получите подтверждение по электронной почте в свой почтовый ящик. Проверьте, не находится ли оно в папке "Нежелательная почта".',
            ),
          ),
          SizedBox(height: 50),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, "/start_menu");
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              padding: EdgeInsets.only(top: 16, bottom: 16),
              decoration: BoxDecoration(
                color: Color(0xff007AFF),
                borderRadius: BorderRadius.circular(5),
              ),
              width: double.infinity,
              child: CustomText(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                align: TextAlign.center,
                text: 'Вернуться к началу',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
