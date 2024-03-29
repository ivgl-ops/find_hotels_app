import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../data/apartmentsData.dart';
import '../widgets/custom_text.dart';

class ScreenPaid extends StatefulWidget {
  const ScreenPaid({Key? key}) : super(key: key);

  @override
  State<ScreenPaid> createState() => _ScreenPaidState();
}

class _ScreenPaidState extends State<ScreenPaid> {
  int roundPrice = 0;
  List<int> priceList = [];
  List searchResult = [];
  final List _docId = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchData();
  }

  void _fetchData() {
    FirebaseFirestore.instance
        .collection('hotels_ru')
        .where('pay', isEqualTo: true)
        .get()
        .then((querySnapshot) {
      setState(() {
        searchResult.addAll(querySnapshot.docs.toList());
      });
    });
  }

  void printDocumentIds() {
    for (var document in searchResult) {
      _docId.add(document.id);
    }
  }

  void _reloadData() {
    FirebaseFirestore.instance
        .collection('hotels_ru')
        .where('like', isEqualTo: true)
        .get()
        .then((querySnapshot) {
      setState(() {
        searchResult.clear();
        searchResult.addAll(querySnapshot.docs.toList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const CustomText(
            text: "Оплаченные апартаменты",
            size: 18,
            color: Colors.blue,
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  searchResult.isEmpty
                      ? FutureBuilder(
                          future: Future.delayed(Duration(seconds: 10)),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: LoadingAnimationWidget.prograssiveDots(
                                  color: Colors.blue,
                                  size: 75,
                                ),
                              );
                            } else {
                              return Center(
                                child: CustomText(
                                  text: 'Пока что у вас нет оплаченных отелей',
                                ),
                              );
                            }
                          },
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(10),
                          itemCount: searchResult.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final bool favoriteHotel =
                                searchResult[index]['like'];
                            printDocumentIds();
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/apartment',
                                  arguments: ApartmentDataView(
                                    searchResult[index],
                                    _docId[index],
                                    int.parse(searchResult[index]['price']),
                                    '2',
                                    Duration(days: 2),
                                  ),
                                ).then((_) => _reloadData());
                              },
                              child: Container(
                                width: double.infinity,
                                height: 300,
                                margin: const EdgeInsets.only(
                                    left: 35, top: 20, right: 25),
                                decoration: const BoxDecoration(
                                    color: Color(0xffE7E7E7),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Stack(
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 20),
                                            height: 150,
                                            width: 250,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                              child: Image.network(
                                                searchResult[index]['img'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              top: 25,
                                              right: 15,
                                              child: favoriteHotel
                                                  ? Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                    )
                                                  : Icon(Icons
                                                      .favorite_border_outlined))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 15,
                                          ),
                                          const Icon(
                                            Icons.people_outline,
                                            color: Colors.blue,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          CustomText(
                                              text: searchResult[index]
                                                  ['rate']),
                                          Spacer(),
                                          const CustomText(
                                              text: '1 спальня 2 человека'),
                                          SizedBox(
                                            width: 15,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 15, top: 10),
                                      child: CustomText(
                                        text: searchResult[index]['name'],
                                        align: TextAlign.start,
                                        size: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 15, top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text:
                                                ('${searchResult[index]['price']} ₽')
                                                    .toString(),
                                            align: TextAlign.start,
                                            size: 13,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          CustomText(text: "За 2-х гостей")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ));
  }
}
