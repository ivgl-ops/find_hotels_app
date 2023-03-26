import 'package:find_hotels_app/data/apartmentsData.dart';
import 'package:find_hotels_app/data/flexibleData.dart';
import 'package:find_hotels_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../firebase/notify.dart';

class PayloadView extends StatefulWidget {
  const PayloadView({Key? key}) : super(key: key);

  @override
  State<PayloadView> createState() => _PayloadViewState();
}

class _PayloadViewState extends State<PayloadView> {
  final _expiryDateController = TextEditingController();
  final _cvcController = TextEditingController();
  final _cardNumberController = TextEditingController();
  String _cardType = '';
  Notify notify = Notify();

  @override
  void initState() {
    super.initState();
    notify.initialiseNotify();
  }

  void _detectCardType(String cardNumber) {
    if (cardNumber.length == 19) {
      FocusScope.of(context).unfocus(); // скрываем клавиатуру
    }
    setState(() {
      // Remove all non-digit characters from card number
      final cardNumberWithoutSpaces = cardNumber.replaceAll(RegExp(r'\D+'), '');
      // Check card number against regular expressions
      if (RegExp(r'^4[0-9]{12}(?:[0-9]{3})?$')
          .hasMatch(cardNumberWithoutSpaces)) {
        _cardType = 'Visa';
      } else if (RegExp(r'^5[1-5][0-9]{14}$')
          .hasMatch(cardNumberWithoutSpaces)) {
        _cardType = 'Mastercard';
      } else if (RegExp(r'^2[2-7][0-9]{14}$')
          .hasMatch(cardNumberWithoutSpaces)) {
        _cardType = 'Mastercard';
      } else if (RegExp(r'^62[0-9]{14}$').hasMatch(cardNumberWithoutSpaces)) {
        _cardType = 'UnionPay';
      } else if (RegExp(
              r'^(220[0-4]|220[6-9]|22[1-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}$')
          .hasMatch(cardNumberWithoutSpaces)) {
        _cardType = 'МИР';
      } else {
        _cardType = '';
      }
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(text: message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> cardNumberFormatters = [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(16),
      // Insert a space after every 4 digits
      _CardNumberTextInputFormatter(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      floatingActionButton: GestureDetector(
        onTap: () {},
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
                  dynamic list =
                      Provider.of<FlexibleData>(context, listen: false)
                          .list;
                  String cardNumber =
                      _cardNumberController.text.replaceAll(" ", "");
                  String cardDate =
                      _expiryDateController.text.replaceAll(" ", "");
                  String cardCVV = _cvcController.text.replaceAll(" ", "");

                  if (cardNumber.length < 16) {
                    _showError("Неправильно введен номер карты");
                  } else if (cardDate.length < 5) {
                    _showError(
                        "Неверная дата истечения срока действия карты оплаты.");
                  } else if (cardCVV.length < 3) {
                    _showError("Неверный код безопасности.");
                  } else {
                    notify.sendNotify(
                        "Добро пожаловать в ${list['name'].toString().toLowerCase()}",
                        "Спасибо за оплату! Мы ждем вас с нетерпением. Приятного отдыха!");
                    Navigator.pushReplacementNamed(
                        context, '/payment_confirmation');
                  }
                },
                child: CustomText(text: 'Продолжить оплату')),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        controller: _cardNumberController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Номер карты',
                          hintText: '1234 5678 9012 3456',
                          suffixText: _cardType,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: cardNumberFormatters,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your card number';
                          }
                          return null;
                        },
                        onChanged: _detectCardType,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          flex: MediaQuery.of(context).size.width < 600 ? 1 : 2,
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: TextFormField(
                                    controller: _expiryDateController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'MM/YY',
                                      hintText: 'MM/YY',
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      MaskTextInputFormatter(mask: '##/##'),
                                      LengthLimitingTextInputFormatter(5),
                                    ],
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length < 4) {
                                        return 'Please enter your expiry date';
                                      }
                                      return null;
                                    },
                                    onChanged: (text) {
                                      if (text.length == 5) {
                                        FocusScope.of(context)
                                            .unfocus(); // скрываем клавиатуру
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          ), // задаем ширину первого Card в зависимости от ширины экрана
                        ),
                        Spacer(),
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: TextFormField(
                                controller: _cvcController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'CVV',
                                  hintText: '123',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your CVV code';
                                  }
                                  return null;
                                },
                                onChanged: (text) {
                                  if (text.length == 3) {
                                    FocusScope.of(context)
                                        .unfocus(); // скрываем клавиатуру
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardNumberTextInputFormatter extends TextInputFormatter {
  static const int maxCardNumberLength = 19;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove all non-digit characters
    String cleanedText = newValue.text.replaceAll(RegExp(r'\D+'), '');
    // Add a space after every 4 digits
    String formattedText = '';
    for (int i = 0; i < cleanedText.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formattedText += ' ';
      }
      formattedText += cleanedText[i];
    }
    // Truncate to max length
    if (formattedText.length > maxCardNumberLength) {
      formattedText = formattedText.substring(0, maxCardNumberLength);
    }
    // Return the new text value with selection position adjusted
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
