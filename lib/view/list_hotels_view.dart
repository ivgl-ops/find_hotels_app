import 'package:find_hotels_app/data/search_hotels.dart';
import 'package:find_hotels_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
              )
            ],
          ),
        ));
  }
}
