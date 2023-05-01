import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/apartmentsData.dart';
import '../widgets/custom_text.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerSurname = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerTel = TextEditingController();

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerSurname.dispose();
    _controllerEmail.dispose();
    _controllerTel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as ApartmentDataView;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: const CustomText(
          text: "Назад",
          size: 16,
          color: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 14,
            ),
            buildFieldName(),
            SizedBox(
              height: 11,
            ),
            buildFieldSurname(),
            SizedBox(
              height: 11,
            ),
            buildFieldEmail(),
            SizedBox(
              height: 11,
            ),
            buildFieldTel()
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/payload',
            arguments: ApartmentDataView(
              args.searchResult,
              args.id,
              args.price,
              args.people,
              args.days,
            ),
          );

          if (kDebugMode) {
            print(
              'addd ${args.id}, ${args.price}, ${args.people}, ${args.days}, ${args.searchResult}');
          }
        },
        child: Container(
          height: 105,
          width: double.infinity,
          margin: EdgeInsets.only(left: 35),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 70,
                offset: Offset(0, -4), // Смещение тени вверх
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            color: Colors.blue,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/payload',
                    arguments: ApartmentDataView(
                      args.searchResult,
                      args.id,
                      args.price,
                      args.people,
                      args.days,
                    ),
                  );
                },
                child: CustomText(text: 'Продолжить оплату')),
          ),
        ),
      ),
    );
  }

  Widget buildFieldName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 30),
          child: CustomText(
            text: "Имя",
            size: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          width: double.infinity,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Имя',
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                letterSpacing: 0.5,
                height: 1.5,
                decorationThickness: 0,
              ),
              contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              isDense: true,
              fillColor: Colors.grey[200],
            ),
            controller: _controllerName,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget buildFieldSurname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 30),
          child: CustomText(
            text: "Фамилия",
            size: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          width: double.infinity,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Ваша фамилия',
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                letterSpacing: 0.5,
                height: 1.5,
                decorationThickness: 0,
              ),
              contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              isDense: true,
              fillColor: Colors.grey[200],
            ),
            controller: _controllerSurname,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget buildFieldEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 30),
          child: CustomText(
            text: "Email",
            size: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          width: double.infinity,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Введите email',
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                letterSpacing: 0.5,
                height: 1.5,
                decorationThickness: 0,
              ),
              contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              isDense: true,
              fillColor: Colors.grey[200],
            ),
            controller: _controllerEmail,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget buildFieldTel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 30),
          child: CustomText(
            text: "Телефон",
            size: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          width: double.infinity,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Введите номер телефона',
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                letterSpacing: 0.5,
                height: 1.5,
                decorationThickness: 0,
              ),
              contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              isDense: true,
              fillColor: Colors.grey[200],
            ),
            controller: _controllerTel,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
