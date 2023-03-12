import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/apartmentsData.dart';
import '../data/search_hotels.dart';
import '../widgets/custom_text.dart';

class ListHotelsView extends StatefulWidget {
  final String city;
  final String places;
  final String level_rooms;
  final String location_type;
  final String budget;
  final bool isRec;

  const ListHotelsView(
      {super.key,
      required this.isRec,
      required this.city,
      required this.places,
      required this.level_rooms,
      required this.location_type,
      required this.budget});

  @override
  _ListHotelsViewState createState() => _ListHotelsViewState();
}

class _ListHotelsViewState extends State<ListHotelsView> {
  int roundPrice = 0;
  List<int> priceList = [];
  List searchResult = [];
  String documentId = '';

  //list
  final _pageSize = 5;
  final _controller = ScrollController();
  var _isFetchingMore = false;
  final List _documents = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
    if (widget.isRec) {
      _fetchDataRec(widget.city, widget.places, widget.level_rooms,
          widget.location_type, widget.budget);
    } else {
      _fetchData();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if (widget.isRec) {
        _loadMoreRec(widget.city, widget.places, widget.level_rooms,
            widget.location_type, widget.budget);
      } else {
        _loadMore();
      }
    }
  }

  void _fetchDataRec(String city, String places, String level_rooms,
      String location_type, String budget) {
    FirebaseFirestore.instance
        .collection('hotels_ru')
        .where('city', isEqualTo: city)
        .where('places', isEqualTo: places)
        .where('level_rooms', isEqualTo: level_rooms)
        .where('location_type', isEqualTo: location_type)
        .where('budget', isEqualTo: budget)
        .limit(_pageSize)
        .get()
        .then((querySnapshot) {
      setState(() {
        _documents.addAll(querySnapshot.docs.map((doc) => {
              'id': doc.id,
              ...doc.data(),
            }));
      });
    });
  }

  void _fetchData() {
    FirebaseFirestore.instance
        .collection('hotels_ru')
        .orderBy('price')
        .limit(_pageSize)
        .get()
        .then((querySnapshot) {
      setState(() {
        _documents.addAll(querySnapshot.docs.map((doc) => {
              'id': doc.id,
              ...doc.data(),
            }));
      });
    });
  }

  void _loadMore() {
    if (!_isFetchingMore) {
      setState(() {
        _isFetchingMore = true;
      });

      FirebaseFirestore.instance
          .collection('hotels_ru')
          .orderBy('price')
          .startAfterDocument(_documents.last)
          .limit(_pageSize)
          .get()
          .then((querySnapshot) {
        setState(() {
          _documents.addAll(querySnapshot.docs.map((doc) => {
                'id': doc.id,
                ...doc.data(),
              }));
          _isFetchingMore = false;
        });
      });
    }
  }

  void _loadMoreRec(String city, String places, String level_rooms,
      String location_type, String budget) {
    if (!_isFetchingMore) {
      setState(() {
        _isFetchingMore = true;
      });

      FirebaseFirestore.instance
          .collection('hotels_ru')
          .orderBy('price')
          .where('city', isEqualTo: city)
          .where('places', isEqualTo: places)
          .where('level_rooms', isEqualTo: level_rooms)
          .where('location_type', isEqualTo: location_type)
          .where('budget', isEqualTo: budget)
          .startAfterDocument(_documents.last)
          .limit(_pageSize)
          .get()
          .then((querySnapshot) {
        setState(() {
          _documents.addAll(querySnapshot.docs.map((doc) => {
                'id': doc.id,
                ...doc.data(),
              }));
          _isFetchingMore = false;
        });
      });
    }
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
    SearchHotels args;
    if (widget.isRec) {
      args =
          SearchHotels(DateTime(1), DateTime(1), 'msk', "2", Duration(days: 1));
    } else {
      args = ModalRoute.of(context)!.settings.arguments as SearchHotels;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Lazy Loading Screen'),
      ),
      body: _documents.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              controller: _controller,
              shrinkWrap: true,
              itemCount: _documents.length + (_isFetchingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _documents.length) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final document = _documents[index];
                final bool favotiteHotel = _documents[index]['like'];
                final city = document['city'] as String;
                final price = document['price'] as String;

                getPriceForPeople(
                  args.days.inDays.toInt() + 1,
                  int.parse(args.people),
                  int.parse(
                    _documents[index]['price'],
                  ),
                );
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/apartment',
                        arguments: ApartmentDataView(
                          _documents[index],
                          priceList[index],
                          args.people,
                          args.days,
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
                                    _documents[index]['img'],
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
                              CustomText(text: _documents[index]['rate']),
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
                            text: _documents[index]['name'],
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
            ),
    );
  }
}
