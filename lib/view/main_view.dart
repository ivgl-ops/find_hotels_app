import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_hotels_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';


class MainView extends StatefulWidget {
  final String name;
   const MainView({super.key, required this.name});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 250,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            )),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 50, right: 10),
                  child: const CustomText(
                    text:
                        "Найдите лучшие предложения на отели,\nапартаменты и многое другое...",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
