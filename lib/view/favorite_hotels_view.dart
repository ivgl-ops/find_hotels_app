import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/apartmentsData.dart';
import '../widgets/custom_text.dart';

class FavoriteHotelsView extends StatefulWidget {
  const FavoriteHotelsView({Key? key}) : super(key: key);

  @override
  State<FavoriteHotelsView> createState() => _FavoriteHotelsViewState();
}

class _FavoriteHotelsViewState extends State<FavoriteHotelsView> {
  @override
  Widget build(BuildContext context) {
    final Query<Map<String, dynamic>> place =
        FirebaseFirestore.instance.collection('favorite');

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const CustomText(
            text: "Избранные аппартаменты",
            size: 16,
            color: Colors.blue,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: place.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 100, bottom: 20),
                            child: CustomText(
                              text:
                                  'На данный момент нет избранных аппартаментов',
                              align: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        final bool favotiteHotel = documentSnapshot['like'];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/apartment',
                              arguments: ApartmentData(
                                documentSnapshot,
                                int.parse(documentSnapshot['price']),
                                '1',
                                Duration(days: 1),
                              ),
                            );
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
                                        margin: const EdgeInsets.only(top: 20),
                                        height: 150,
                                        width: 250,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          child: Image.network(
                                            documentSnapshot['img'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: 25,
                                          right: 15,
                                          child: favotiteHotel
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
                                          text: documentSnapshot['rate']),
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
                                  margin:
                                      const EdgeInsets.only(left: 15, top: 10),
                                  child: CustomText(
                                    text: documentSnapshot['name'],
                                    align: TextAlign.start,
                                    size: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 15, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: ('${documentSnapshot['price']} ₽')
                                            .toString(),
                                        align: TextAlign.start,
                                        size: 13,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      CustomText(
                                          text:
                                              "За ${1 + 1} ночей и ${1} гостей")
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
            ],
          ),
        ));
  }
}
