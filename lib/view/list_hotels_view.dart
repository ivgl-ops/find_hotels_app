import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../data/apartmentsData.dart';
import '../data/search_hotels.dart';
import '../firebase/get_hotels.dart';
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
  final List _docId = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
        .limit(widget.isRec ? 3 : _pageSize)
        .get()
        .then((querySnapshot) {
      setState(() {
        _documents.addAll(querySnapshot.docs.toList());
      });
    });
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
          _documents.addAll(querySnapshot.docs.toList());
          _isFetchingMore = false;
        });
      });
    }
  }

  void printDocumentIds() {
    for (var document in _documents) {
      _docId.add(document.id);
    }
  }

  void _fetchData() {
    FirebaseFirestore.instance
        .collection('hotels_ru')
        .where('city',
            isEqualTo: Provider.of<GetHotel>(context, listen: false).nameHotels)
        .limit(_pageSize)
        .get()
        .then((querySnapshot) {
      setState(() {
        _documents.addAll(querySnapshot.docs.toList());
      });
    });
  }

  void _reloadData() {
    FirebaseFirestore.instance
        .collection('hotels_ru')
        .where('city',
        isEqualTo: Provider.of<GetHotel>(context, listen: false).nameHotels)
        .limit(_pageSize)
        .get()
        .then((querySnapshot) {
      setState(() {
        _documents.clear();
        _documents.addAll(querySnapshot.docs.toList());
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
          .where('city', isEqualTo: Provider.of<GetHotel>(context).nameHotels)
          .startAfterDocument(_documents.last)
          .limit(_pageSize)
          .get()
          .then((querySnapshot) {
        setState(() {
          _documents.addAll(querySnapshot.docs);
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
    String docId = '';
    SearchHotels args;
    if (widget.isRec) {
      args =
          SearchHotels(DateTime(1), DateTime(1), 'msk', "2", Duration(days: 1));
    } else {
      args = ModalRoute.of(context)!.settings.arguments as SearchHotels;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (widget.isRec) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/start_menu', (route) => false);
            } else {
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        title: CustomText(
          color: Colors.blue,
          text: widget.isRec ? 'На главную' : 'Отели',
        ),
      ),
      body: _documents.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  widget.isRec
                      ? Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 25, right: 20, top: 25),
                          child: CustomText(
                            text:
                                'Мы подобрали для вас наиболее подходящие варианты в городе ${widget.city}',
                            fontWeight: FontWeight.bold,
                            size: 23,
                            align: TextAlign.center,
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 25,
                  ),
                  ListView.builder(
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
                      printDocumentIds();
                      final bool favotiteHotel = _documents[index]['like'];
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
                                _docId[index],
                                priceList[index],
                                args.people,
                                args.days,
                              )).then((_) => _reloadData());
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
                                            : Icon(
                                                Icons.favorite_border_outlined))
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
                                      Icons.star,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(text: '${_documents[index]['rate']} /  10'),
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
                                  text: _documents[index]['name'],
                                  align: TextAlign.start,
                                  size: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 15, top: 10),
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
                ],
              ),
            ),
    );
  }
}
