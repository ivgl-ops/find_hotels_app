import 'package:find_hotels_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class PaymentConfirmationWidget extends StatelessWidget {
  const PaymentConfirmationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            text: 'Оплата успешно подтверждена!',
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
