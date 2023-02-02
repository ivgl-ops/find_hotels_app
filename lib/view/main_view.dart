import 'package:animate_gradient/animate_gradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_hotels_app/viewModel/num_person_viewmodel.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
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
                                "Найдите лучшие предложения на отели,апартаменты\n и многое другое...",
                            color: Colors.white,
                            size: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(top: 30, left: 30, right: 30),
                          height: 40,
                          child: TextField(
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
                                  onPressed: () {},
                                )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding:const EdgeInsets.only(right: 15),
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
                                  const CustomText(
                                    text: "2 августа - 10 августа",
                                    fontWeight: FontWeight.bold,
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
                                margin: const EdgeInsets.only(top: 20, right: 30),
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
                                      text: context
                                          .read<NumPersonViewModel>()
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
              stream: Provider.of<GetHotel>(context).hotel.snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                 
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                            documentSnapshot['name'],
                          ),
                          subtitle: Text(
                            documentSnapshot['price'].toString(),
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
      ),
    );
  }
}
