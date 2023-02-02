import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_hotels_app/data/search_hotels.dart';
import 'package:find_hotels_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class ListHotelsView extends StatefulWidget {
  const ListHotelsView({super.key});

  @override
  State<ListHotelsView> createState() => _ListHotelsViewState();
}

class _ListHotelsViewState extends State<ListHotelsView> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SearchHotels;
    final CollectionReference place =
        FirebaseFirestore.instance.collection(args.city.toLowerCase());
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xffE7E7E7),
                ),
                child: Center(
                  child: CustomText(
                    text:
                        "${args.city} | ${DateFormat('MM/dd').format(args.start)} до ${DateFormat('MM/dd').format(args.end)} | ${args.people.toString()} гость ",
                    fontWeight: FontWeight.bold,
                    size: 15,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 156,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color(0xffE7E7E7),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.sort,
                        ),
                        CustomText(text: "Сортировать")
                      ],
                    ),
                  ),
                  Container(
                    width: 130,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color(0xffE7E7E7),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.settings,
                        ),
                        CustomText(text: "Фильтр")
                      ],
                    ),
                  ),
                  Container(
                    width: 130,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color(0xffE7E7E7),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.map,
                        ),
                        CustomText(text: "Карта")
                      ],
                    ),
                  ),
                ],
              ),
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
                            child: const CustomText(
                                text: 'Данного напраления пока не существует'),
                          ),
                          GestureDetector(
                            onTap: (() {
                              Navigator.pop(context);
                            }),
                            child: Container(
                                width: 300,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Color(0xff007AFF),
                                ),
                                child: const Center(
                                  child: CustomText(
                                    text: 'Вернуться на главную страницу',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          )
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
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
                              CustomText(text: documentSnapshot['name'])
                            ],
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
