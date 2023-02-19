import 'package:find_hotels_app/data/apartmentsData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text.dart';

class ApartmentView extends StatefulWidget {
  const ApartmentView({Key? key}) : super(key: key);

  @override
  State<ApartmentView> createState() => _ApartmentViewState();
}

class _ApartmentViewState extends State<ApartmentView> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ApartmentData;
    return Scaffold(
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
          text: "Вернуться к отелям",
          size: 16,
          color: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: double.infinity,
              height: 240,
              child: Image.network(
                args.documentSnapshot["img"],
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 1,
                ),
                Spacer(),
                Icon(Icons.favorite_border_rounded),
                SizedBox(
                  width: 28,
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffE7E7E7),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      CustomText(
                        text: args.documentSnapshot['name'],
                        fontWeight: FontWeight.bold,
                        size: 14,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      CustomText(
                        text:
                            '${args.days.inDays + 1} ночей ${args.people} гостей',
                        fontWeight: FontWeight.w600,
                        size: 14,
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 21, bottom: 10),
                            child: CustomText(
                              text: '${args.price.toString()} ₽',
                              fontWeight: FontWeight.w600,
                              size: 25,
                              color: Color(0xff007AFF),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffE7E7E7),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.people_outline,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      CustomText(
                        text: args.documentSnapshot['rate'],
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: CustomText(
                          text: 'Посмотреть 140 отзывов',
                          underline: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black,
                        size: 15,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffE7E7E7),
                borderRadius: BorderRadius.circular(25),
              ),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                     Container(
                       margin: EdgeInsets.symmetric(horizontal: 5),

                       child: CustomText(
                          text:
                              "К услугам гостей этого отеля терраса и небольшой бассейн на крыше, открытый круглый год. Отель находится напротив ботанического сада Валенсии и торгового центра New Centro, а также располагает тренажерным залом и сауной.К услугам гостей отеля NH Valencia Center элегантно оформленные звукоизолированные номера с кондиционером, бесплатным Wi-Fi и телевизором с плоским экраном и спутниковыми каналами. В собственной ванной комнате предоставляются туалетно-косметические принадлежности.Отель NH Valencia Center находится в 5 минутах ходьбы от станции метро Túria, откуда можно легко добраться до центра Валенсии. Гостям предоставляется скидка 20% на пользование общественной парковкой, до которой можно добраться прямо из отеля."),
                     ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
