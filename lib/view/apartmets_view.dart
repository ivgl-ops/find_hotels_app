import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_hotels_app/data/apartmentsData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text.dart';

class ApartmentView extends StatefulWidget {
  const ApartmentView({Key? key}) : super(key: key);

  @override
  State<ApartmentView> createState() => _ApartmentViewState();
}

class _ApartmentViewState extends State<ApartmentView> {
  bool? fav;
  late final args;
   dynamic list = {};

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      var args = ModalRoute.of(context)!.settings.arguments;
      if (args != null) {
        args = args as ApartmentDataView;
        fav = args.searchResult['like'];
        list = args.searchResult;
      }
      setState(() {});
    });
  }

  void searchfromFirebase(String query) async {
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('hotels_ru')
          .doc(args.searchResult['id'])
          .get();
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data();
        print('Data for document ${args.searchResult['id']}: $data');
      } else {
        print('Document with ID ${args.searchResult['id']} does not exist');
      }
    } catch (error) {
      print('Error getting document: $error');
    }
    setState(() {});
  }

  Future<void> updateFavoriteField(String documentId, bool newValue) async {
    try {
      // Get a reference to the document to update
      final documentReference =
          FirebaseFirestore.instance.collection('hotels_ru').doc(documentId);

      // Update the 'favorite' field
      await documentReference.update({'like': newValue});

      print('Favorite field updated successfully!');
    } catch (error) {
      print('Error updating favorite field: $error');
    }
  }

  void onFavoriteButtonPressed(String documentId, bool currentValue) async {
    // Calculate the new value for the 'favorite' field
    final newValue = !currentValue;

    // Update the 'favorite' field in Firebase
    updateFavoriteField(documentId, newValue);

    // Reload the data from Firebase

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ApartmentDataView;

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
          text: "?????????????????? ?? ????????????",
          size: 16,
          color: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),

            SizedBox(
              width: double.infinity,
              height: 240,
              child: list['img'] != null
                  ? Image.network(
                      list['img'],
                      fit: BoxFit.fill,
                    )
                  : Container(),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                SizedBox(
                  width: 1,
                ),
                Spacer(),
                fav == true
                    ? IconButton(
                        onPressed: () async {
                          print(args.id);
                          onFavoriteButtonPressed(args.id, list['like']);
                          fav = false;
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.favorite_outlined,
                          color: Colors.red,
                        ))
                    : IconButton(
                        onPressed: () async {
                          print(args.id);
                          onFavoriteButtonPressed(args.id, list['like']);
                          fav = true;
                          setState(() {});
                        },
                        icon: Icon(Icons.favorite_border_outlined)),
                SizedBox(
                  width: 28,
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffE7E7E7),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      CustomText(
                        text: list['name'] ?? '',
                        fontWeight: FontWeight.bold,
                        size: 14,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      CustomText(
                        text:
                            '${args.days.inDays + 1} ?????????? ${args.people} ????????????',
                        fontWeight: FontWeight.w600,
                        size: 14,
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 21, bottom: 10),
                            child: CustomText(
                              text: '${args.price.toString()} ???',
                              fontWeight: FontWeight.w600,
                              size: 25,
                              color: Color(0xff007AFF),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffE7E7E7),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.people_outline,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      CustomText(
                        text: list['rate'].toString(),
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: CustomText(
                          text: '???????????????????? 140 ??????????????',
                          underline: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black,
                        size: 15,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffE7E7E7),
                borderRadius: BorderRadius.circular(25),
              ),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: CustomText(
                          text:
                              "?? ?????????????? ???????????? ?????????? ?????????? ?????????????? ?? ?????????????????? ?????????????? ???? ??????????, ???????????????? ?????????????? ??????. ?????????? ?????????????????? ???????????????? ?????????????????????????? ???????? ???????????????? ?? ?????????????????? ???????????? New Centro, ?? ?????????? ?????????????????????? ?????????????????????? ?????????? ?? ????????????.?? ?????????????? ???????????? ?????????? NH Valencia Center ?????????????????? ?????????????????????? ???????????????????????????????????? ???????????? ?? ??????????????????????????, ???????????????????? Wi-Fi ?? ?????????????????????? ?? ?????????????? ?????????????? ?? ???????????????????????? ????????????????. ?? ?????????????????????? ???????????? ?????????????? ?????????????????????????????? ????????????????-?????????????????????????? ????????????????????????????.?????????? NH Valencia Center ?????????????????? ?? 5 ?????????????? ???????????? ???? ?????????????? ?????????? T??ria, ???????????? ?????????? ?????????? ?????????????????? ???? ???????????? ????????????????. ???????????? ?????????????????????????????? ???????????? 20% ???? ?????????????????????? ???????????????????????? ??????????????????, ???? ?????????????? ?????????? ?????????????????? ?????????? ???? ??????????."),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
