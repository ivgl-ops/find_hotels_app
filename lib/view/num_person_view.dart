import 'package:find_hotels_app/viewModel/num_person_viewmodel.dart';
import 'package:find_hotels_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class NumPersonView extends StatefulWidget {
  const NumPersonView({super.key});

  @override
  State<NumPersonView> createState() => _NumPersonViewState();
}

class _NumPersonViewState extends State<NumPersonView> {
  @override
  Widget build(BuildContext context) {
    int counterAdults = Provider.of<NumPersonViewModel>(context).counterAdults;
    int counterChildren =
        Provider.of<NumPersonViewModel>(context).counterChildren;
    int counterHotelRoom =
        Provider.of<NumPersonViewModel>(context).counterHotelRoom;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const CustomText(
                text: "Сколько будет человек?",
                fontWeight: FontWeight.bold,
                color: Colors.white,
                size: 28,
                align: TextAlign.start,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: double.infinity,
              height: 500,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),

              // ROW CHOOSE ADULTS
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const CustomText(
                          text: "Взрослые",
                          size: 25,
                        ),
                        IconButton(
                          onPressed: () {
                            context
                                .read<NumPersonViewModel>()
                                .decrementCounterAdults();
                          },
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            size: 30,
                          ),
                        ),
                        CustomText(
                          text: counterAdults.toString(),
                          size: 30,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              context
                                  .read<NumPersonViewModel>()
                                  .incrementCounterAdults();
                            });
                          },
                          icon: const Icon(
                            Icons.add_circle_outline,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                  //ROW CHOOSE CHILDREN
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CustomText(
                        text: "Дети",
                        size: 25,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 61),
                        child: IconButton(
                          onPressed: () {
                            context
                                .read<NumPersonViewModel>()
                                .decrementCounterChildren();
                          },
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            size: 30,
                          ),
                        ),
                      ),
                      CustomText(
                        text: counterChildren.toString(),
                        size: 30,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            context
                                .read<NumPersonViewModel>()
                                .incrementCounterChildren();
                          });
                        },
                        icon: const Icon(
                          Icons.add_circle_outline,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  //ROW CHOOSE HOTEL ROOMS
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const CustomText(
                          text: "Номера",
                          size: 25,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 19),
                          child: IconButton(
                            onPressed: () {
                              context
                                  .read<NumPersonViewModel>()
                                  .decrementCounterHotelRoom();
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              size: 30,
                            ),
                          ),
                        ),
                        CustomText(
                          text: counterHotelRoom.toString(),
                          size: 30,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              context
                                  .read<NumPersonViewModel>()
                                  .incrementCounterHotelRoom();
                            });
                          },
                          icon: const Icon(
                            Icons.add_circle_outline,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<NumPersonViewModel>(context, listen: false)
                          .totalPeople();
                      Navigator.pop(context);
                      //Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      margin: const EdgeInsets.only(right: 30, left: 30),
                      color: const Color(0xff007AFF),
                      child: const Center(
                        child: CustomText(
                          text: "Подтведить",
                          size: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
