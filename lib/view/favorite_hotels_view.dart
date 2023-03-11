import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_hotels_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../data/apartmentsData.dart';

class FavoriteHotelsView extends StatefulWidget {
  const FavoriteHotelsView({Key? key}) : super(key: key);

  @override
  State<FavoriteHotelsView> createState() => _FavoriteHotelsViewState();
}

class _FavoriteHotelsViewState extends State<FavoriteHotelsView> {
  late CollectionReference moscowCollection;
  List<Map<String, dynamic>> likeDocuments = [];

  @override
  void initState() {
    super.initState();
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    moscowCollection = firestore.collection('москва');
    // Вызовите метод обновления данных при инициализации экрана
    updateData();
    // Затем через определенный промежуток времени вызовите этот метод повторно
    Timer.periodic(Duration(seconds: 10), (Timer t) => updateData());
  }

  // Метод для обновления данных
  void updateData() async {
    List<Map<String, dynamic>> data = await getLikeDocuments();
    setState(() {
      likeDocuments = data;
    });
  }

  Future<List<Map<String, dynamic>>> getLikeDocuments() async {
    QuerySnapshot snapshot = await moscowCollection.get();
    List<Map<String, dynamic>> data = [];

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      if (doc['like'] == true) {
        data.add({
          'id': doc.id,
          'name': doc['name'],
          'price': doc['price'],
          'city': doc['city'],
          'like': doc['like'],
          'rate': doc['rate'],
          'img': doc['img'],
        });
      }
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText(
          text: 'Избранное',
          color: Colors.lightBlue,
        ),
        elevation: 0,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getLikeDocuments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Показываем индикатор загрузки, пока документы не загрузятся
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // Если документы успешно загружены, отображаем их в ListView
            final likeDocuments = snapshot.data!;
            return ListView.builder(
              itemCount: likeDocuments.length,
              itemBuilder: (BuildContext context, int index) {
                final bool favoriteHotel = likeDocuments[index]['like'];
                return GestureDetector(
                  onTap: () {
                    print('hello ${likeDocuments[index]['name']}');
                    Navigator.pushNamed(context, '/apartment',
                        arguments: ApartmentDataView(
                          likeDocuments[index],
                          int.parse(likeDocuments[index]['price']),
                          '2',
                          Duration(days: 2),
                        ));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    margin: const EdgeInsets.only(left: 35, top: 20, right: 25),
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
                                    likeDocuments[index]['img'],
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
                              CustomText(text: likeDocuments[index]['rate']),
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
                            text: likeDocuments[index]['name'],
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
                                text: ('${likeDocuments[index]['price']} ₽')
                                    .toString(),
                                align: TextAlign.start,
                                size: 13,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
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

          // Если документов нет, показываем сообщение об отсутствии данных
          return Center(child: Text('Нет избранных отелей'));
        },
      ),
    );
  }
}
