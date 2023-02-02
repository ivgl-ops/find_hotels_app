import 'package:animate_gradient/animate_gradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_hotels_app/data/search_hotels.dart';
import 'package:find_hotels_app/viewModel/num_person_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../firebase/get_hotels.dart';
import '../widgets/custom_text.dart';

class MainView extends StatefulWidget {
  const MainView({
    super.key,
  });

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 6)));
  final startYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
  final startMounth = int.parse(DateFormat('M').format(DateTime.now()));
  final startDays = int.parse(DateFormat('d').format(DateTime.now()));
  final cityController = TextEditingController();

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        helpText: 'Выберите дату заселения и выселения',
        saveText: 'Сохранить',
        locale: const Locale("ru"),
        initialDateRange: dateRange,
        firstDate: DateTime(startYear, startMounth, startDays),
        lastDate: DateTime(startYear + 1, startMounth + 1));
    if (newDateRange == null) return;
    setState(() => dateRange = newDateRange);
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimateGradient(
              primaryBegin: Alignment.topLeft,
              primaryEnd: Alignment.bottomLeft,
              secondaryBegin: Alignment.bottomLeft,
              secondaryEnd: Alignment.topRight,
              primaryColors: const [Color(0XFF007AFF), Color(0xffFF001F)],
              secondaryColors: const [
                Colors.blueAccent,
                Colors.blue,
              ],
              child: Container(
                  margin: const EdgeInsets.only(top: 70),
                  width: double.infinity,
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 70, right: 70),
                          child: const CustomText(
                            align: TextAlign.center,
                            text:
                                "Найдите лучшие предложения на отели, апартаменты\n и многое другое...",
                            color: Colors.white,
                            size: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 30, left: 30, right: 30),
                          height: 40,
                          child: TextField(
                            controller: cityController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(left: 15),
                                hintText: 'Москва',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 5, //<-- SEE HERE
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 5, //<-- SEE HERE
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/search',
                                        arguments: SearchHotels(
                                            start,
                                            end,
                                            cityController.text,
                                            Provider.of<NumPersonViewModel>(
                                                    context, listen: false)
                                                .total
                                                .toString()));
                                  },
                                )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 15),
                              height: 40,
                              margin: const EdgeInsets.only(left: 30, top: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 14),
                                      child: const Icon(Icons.calendar_today)),
                                  GestureDetector(
                                    onTap: () {
                                      pickDateRange();
                                    },
                                    child: CustomText(
                                      text:
                                          "с ${DateFormat('MM/dd').format(start)} до ${DateFormat('MM/dd').format(end)} ",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/num');
                              },
                              child: Container(
                                padding: const EdgeInsets.only(right: 15),
                                height: 40,
                                margin:
                                    const EdgeInsets.only(top: 20, right: 30),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Row(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, right: 14),
                                        child: const Icon(
                                          Icons.person,
                                          size: 28,
                                        )),
                                    CustomText(
                                      text: Provider.of<NumPersonViewModel>(
                                              context)
                                          .total
                                          .toString(),
                                      fontWeight: FontWeight.bold,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 15),
              child: const CustomText(
                text: "Популярные направления",
                fontWeight: FontWeight.bold,
                size: 25,
                align: TextAlign.end,
              ),
            ),
            StreamBuilder(
              stream: Provider.of<GetHotel>(context).offer.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SizedBox(
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        return Container(
                          width: 190,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          margin: const EdgeInsets.only(left: 20, top: 20),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                    width: 150,
                                    height: 100,
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        documentSnapshot['img'].toString())),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: CustomText(
                                      text: documentSnapshot['name']))
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
