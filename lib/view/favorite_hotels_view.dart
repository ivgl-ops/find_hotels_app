import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_hotels_app/data/apartmentsData.dart';
import 'package:find_hotels_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../firebase/get_hotels.dart';

class FavoriteHotelsView extends StatefulWidget {
  const FavoriteHotelsView({super.key});

  @override
  State<FavoriteHotelsView> createState() => _FavoriteHotelsViewState();
}

class _FavoriteHotelsViewState extends State<FavoriteHotelsView> {
  int roundPrice = 0;
  List<int> priceList = [];
  List searchResult = [];
  String documentId = '';

  void searchfromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('hotels_ru')
        .where('like', isEqualTo: true)
        .get();

    setState(() {
      searchResult = result.docs
          .map((doc) => {
                'id': doc.id,
                ...doc.data(),
              })
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Query<Map<String, dynamic>> place = FirebaseFirestore.instance
        .collection('hotels_ru')
        .orderBy(context.watch<GetHotel>().getHotels,
            descending: context.watch<GetHotel>().maxtoMinRate);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const CustomText(
          text: "Избранные отели",
          size: 18,
          color: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: place.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            searchfromFirebase('hotels_ru');
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (searchResult.isEmpty) {
                return Center(
                  child: CustomText(
                    text: 'У вас нет избранных отелей',
                  ),
                );
              }
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10),
                itemCount: searchResult.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final bool favoriteHotel = searchResult[index]['like'];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/apartment',
                        arguments: ApartmentDataView(
                          searchResult[index],
                          '',
                          int.parse(searchResult[index]['price']),
                          '2',
                          Duration(days: 2),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      margin:
                          const EdgeInsets.only(left: 35, top: 20, right: 25),
                      decoration: const BoxDecoration(
                          color: Color(0xffE7E7E7),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  height: 150,
                                  width: 250,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25.0),
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
                                        : Icon(Icons.favorite_border_outlined))
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
                                CustomText(text: searchResult[index]['rate']),
                                Spacer(),
                                const CustomText(text: '1 спальня 2 человека'),
                                SizedBox(
                                  width: 15,
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 15, top: 10),
                            child: CustomText(
                              text: searchResult[index]['name'],
                              align: TextAlign.start,
                              size: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 15, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: ('${searchResult[index]['price']} ₽')
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
              );
            }
          },
        ),
      ),
    );
  }
}
