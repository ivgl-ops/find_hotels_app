import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_hotels_app/data/apartmentsData.dart';
import 'package:find_hotels_app/data/search_hotels.dart';
import 'package:find_hotels_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../firebase/get_hotels.dart';

class ListHotelsView extends StatefulWidget {
  const ListHotelsView({super.key});

  @override
  State<ListHotelsView> createState() => _ListHotelsViewState();
}

class _ListHotelsViewState extends State<ListHotelsView> {
  String _selectedGender = 'От 10 до 0';
  int roundPrice = 0;
  List<int> priceList = [];
  List searchResult = [];
  String documentId = '';

  void searchfromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('москва')
        .where('city', isEqualTo: 'msk')
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


  void getPriceForPeople(int days, var countPeople, int price) {
    double totalPrice;
    double rooms;
    if (countPeople.isEven) {
      rooms = countPeople / 2;
      totalPrice = days * rooms * price;
      roundPrice = totalPrice.toInt();
      priceList.add(roundPrice);
    } else {
      rooms = countPeople / 2 + 1;
      rooms = double.parse(rooms.toStringAsFixed(0)) - 1;
      totalPrice = days * rooms * price;
      roundPrice = totalPrice.toInt();
      priceList.add(roundPrice);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SearchHotels;

    final Query<Map<String, dynamic>> place = FirebaseFirestore.instance
        .collection(args.city.toLowerCase())
        .orderBy(context.watch<GetHotel>().getHotels,
            descending: context.watch<GetHotel>().maxtoMinRate);

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
            text: "Вернуться на главную",
            size: 16,
            color: Colors.blue,
          ),
        ),
        body: Scrollbar(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              children: [
                                AlertDialog(
                                  scrollable: true,
                                  title: const CustomText(
                                    text: 'Сортировать по: ',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  content: Column(
                                    children: [
                                      ListTile(
                                        leading: Radio<String>(
                                          value: 'От 0 до 10',
                                          groupValue: _selectedGender,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedGender = value!;
                                            });
                                            context
                                                .read<GetHotel>()
                                                .changeRateMin();
                                            Navigator.pop(context);
                                          },
                                        ),
                                        title: const CustomText(
                                            text: 'Оценка (от 0 до 10)'),
                                      ),
                                      ListTile(
                                        leading: Radio<String>(
                                          value: 'От 10 до 0',
                                          groupValue: _selectedGender,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedGender = value!;
                                            });
                                            context
                                                .read<GetHotel>()
                                                .changeRateMax();
                                            Navigator.pop(context);
                                          },
                                        ),
                                        title: const CustomText(
                                            text: 'Оценка (от 10 до 0)'),
                                      ),
                                      ListTile(
                                        leading: Radio<String>(
                                          value: 'дешево',
                                          groupValue: _selectedGender,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedGender = value!;
                                            });
                                            context
                                                .read<GetHotel>()
                                                .changeRateMin();
                                            Navigator.pop(context);
                                          },
                                        ),
                                        title: const CustomText(
                                            text:
                                                'Цена (от самой низкой к самой высокой)'),
                                      ),
                                      ListTile(
                                        leading: Radio<String>(
                                          value: 'дорого',
                                          groupValue: _selectedGender,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedGender = value!;
                                            });
                                            context
                                                .read<GetHotel>()
                                                .changeRateMax();
                                            Navigator.pop(context);
                                          },
                                        ),
                                        title: const CustomText(
                                            text:
                                                'Цена (от самой высокой к самой низкой)'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color(0xffE7E7E7),
                      ),
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.sort,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CustomText(
                            text: "Сортировать",
                            size: 10,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/filter');
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color(0xffE7E7E7),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.settings,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              text: "Фильтр",
                              size: 10,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/filter');
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color(0xffE7E7E7),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.map_outlined,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              text: "Карта",
                              size: 10,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              StreamBuilder(
                stream: place.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  searchfromFirebase('москва');
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
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      itemCount: searchResult.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        final bool favotiteHotel = searchResult[index]['like'];
                        getPriceForPeople(
                          args.days.inDays.toInt() + 1,
                          int.parse(args.people),
                          int.parse(
                            searchResult[index]['price'],
                          ),
                        );
                        //TODO: Переделать прием аргументов. Так как выводятся не правильно карточки
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/apartment',
                                arguments: ApartmentDataView(
                                  searchResult[index],
                                  priceList[index],
                                  args.people,
                                  args.days,
                                ));
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
                                            searchResult[index]['img'],
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
                                          text: searchResult[index]['rate']),
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
                                    text: searchResult[index]['name'],
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
                                        text: ('$roundPrice ₽').toString(),
                                        align: TextAlign.start,
                                        size: 13,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      CustomText(
                                          text:
                                              "За ${args.days.inDays + 1} ночей и ${args.people} гостей")
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
        )));
  }
}
