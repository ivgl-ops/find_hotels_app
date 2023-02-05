import 'package:find_hotels_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class FilterHotelsView extends StatefulWidget {
  const FilterHotelsView({super.key});

  @override
  State<FilterHotelsView> createState() => _FilterHotelsViewState();
}

class _FilterHotelsViewState extends State<FilterHotelsView> {
  String all = 'All';
  String bed1 = 'bed1';
  String bed2 = 'bed2';
  String category1 = 'hotel';
  String category2 = 'hostel';
  String category3 = 'apartment';
  List<String> selectedCategoryBed = <String>[];
  List<String> selectedCategoryHotel = <String>[];
  List<String> selectedCategoryStars = <String>[];
  List<String> selectedCategoryFilter = <String>[];
  String stars1 = 'stars1';
  String stars2 = 'stars2';
  String stars3 = 'stars3';
  String stars4 = 'stars4';
  String stars5 = 'stars5';
  String filer1 = 'filter1';
  String filer2 = 'filter2';
  String filer3 = 'filter3';
  String filer4 = 'filter4';
  bool vertical = false;

  RangeValues _currentRangeValues = const RangeValues(2000, 20000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const CustomText(
          text: "Вернуться",
          color: Colors.blue,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 25,  bottom: 10),
              child: const CustomText(
                text: "Ваш бюджет",
                fontWeight: FontWeight.bold,
                size: 22,
                align: TextAlign.start,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  SizedBox(
                    width: 200,
                    child: CustomText(text: "1500 ₽"),
                  ),
                  SizedBox(
                    width: 200,
                    child: CustomText(
                      text: "2500 ₽+",
                      align: TextAlign.end,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: RangeSlider(
                values: _currentRangeValues,
                max: 25000,
                min: 1500,
                divisions: 100,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, bottom: 20, top: 20),
              child: const CustomText(
                text: "Сортировать по:",
                fontWeight: FontWeight.bold,
                size: 22,
                align: TextAlign.start,
              ),
            ),
            Center(
              child: Column(
                children: [
                  InkWell(
                    splashColor: Colors.blue[100],
                    onTap: () {
                      selectedCategoryFilter = <String>[];
                      selectedCategoryFilter.add(filer1);
                      setState(() {});
                    },
                    child: Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: selectedCategoryFilter.contains(filer1)
                            ? Colors.blue[100]
                            : Colors.grey[300],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(48.0)),
                      ),
                      child: const CustomText(
                        text: "Оценка (от 10 до 0)",
                        align: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 2.0,
                  ),
                  InkWell(
                    splashColor: Colors.blue[100],
                    onTap: () {
                      selectedCategoryFilter = <String>[];
                      selectedCategoryFilter.add(filer2);
                      setState(() {});
                    },
                    child: Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: selectedCategoryFilter.contains(filer2)
                            ? Colors.blue[100]
                            : Colors.grey[300],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(48.0)),
                      ),
                      child: const CustomText(
                        text: "Оценка от 0 до 10",
                        align: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 2.0,
                  ),
                  InkWell(
                    splashColor: Colors.blue[100],
                    onTap: () {
                      selectedCategoryFilter = <String>[];
                      selectedCategoryFilter.add(filer3);
                      setState(() {});
                    },
                    child: Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: selectedCategoryFilter.contains(filer3)
                            ? Colors.blue[100]
                            : Colors.grey[300],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(48.0)),
                      ),
                      child: const CustomText(
                        text: "Цена(от самой высокой к самой низкой)",
                        align: TextAlign.center,
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.blue[100],
                    onTap: () {
                      selectedCategoryFilter = <String>[];
                      selectedCategoryFilter.add(filer4);
                      setState(() {});
                    },
                    child: Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: selectedCategoryFilter.contains(filer4)
                            ? Colors.blue[100]
                            : Colors.grey[300],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(48.0)),
                      ),
                      child: const CustomText(
                        text: "Цена(от самой низкой к самой высокой)",
                        align: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 20, bottom: 20, top: 20),
                child: const CustomText(
                  text: "Категории",
                  fontWeight: FontWeight.bold,
                  size: 22,
                  align: TextAlign.start,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  splashColor: Colors.blue[100],
                  onTap: () {
                    selectedCategoryHotel = <String>[];
                    selectedCategoryHotel.add(category1);
                    setState(() {});
                  },
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: selectedCategoryHotel.contains(category1)
                          ? Colors.blue[100]
                          : Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(48.0)),
                    ),
                    child: const CustomText(
                      text: "Отели",
                      align: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 2.0,
                ),
                InkWell(
                  splashColor: Colors.blue[100],
                  onTap: () {
                    selectedCategoryHotel = <String>[];
                    selectedCategoryHotel.add(category2);
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: selectedCategoryHotel.contains(category2)
                          ? Colors.blue[100]
                          : Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(48.0)),
                    ),
                    child: const CustomText(
                      text: "Хостелы",
                      align: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 2.0,
                ),
                InkWell(
                  splashColor: Colors.blue[100],
                  onTap: () {
                    selectedCategoryHotel = <String>[];
                    selectedCategoryHotel.add(category3);
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: selectedCategoryHotel.contains(category3)
                          ? Colors.blue[100]
                          : Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(48.0)),
                    ),
                    child: const CustomText(
                      text: "Аппартаменты",
                      align: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, bottom: 20, top: 20),
              child: const CustomText(
                text: "Звезды",
                fontWeight: FontWeight.bold,
                size: 22,
                align: TextAlign.start,
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      splashColor: Colors.blue[100],
                      onTap: () {
                        selectedCategoryStars = <String>[];
                        selectedCategoryStars.add(stars1);
                        setState(() {});
                      },
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: selectedCategoryStars.contains(stars1)
                              ? Colors.blue[100]
                              : Colors.grey[300],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(48.0)),
                        ),
                        child: const CustomText(
                          text: "1 звезда",
                          align: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 2.0,
                    ),
                    InkWell(
                      splashColor: Colors.blue[100],
                      onTap: () {
                        selectedCategoryStars = <String>[];
                        selectedCategoryStars.add(stars2);
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: selectedCategoryStars.contains(stars2)
                              ? Colors.blue[100]
                              : Colors.grey[300],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(48.0)),
                        ),
                        child: const CustomText(
                          text: "2 звезды",
                          align: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 2.0,
                    ),
                    InkWell(
                      splashColor: Colors.blue[100],
                      onTap: () {
                        selectedCategoryStars = <String>[];
                        selectedCategoryStars.add(stars3);
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: selectedCategoryStars.contains(stars3)
                              ? Colors.blue[100]
                              : Colors.grey[300],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(48.0)),
                        ),
                        child: const CustomText(
                          text: "3 звезды",
                          align: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      const SizedBox(
                        width: 2.0,
                      ),
                      InkWell(
                        splashColor: Colors.blue[100],
                        onTap: () {
                          selectedCategoryStars = <String>[];
                          selectedCategoryStars.add(stars4);
                          setState(() {});
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 12.0),
                          decoration: BoxDecoration(
                            color: selectedCategoryStars.contains(stars4)
                                ? Colors.blue[100]
                                : Colors.grey[300],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(48.0)),
                          ),
                          child: const CustomText(
                            text: "4 звезды",
                            align: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 2.0,
                      ),
                      InkWell(
                        splashColor: Colors.blue[100],
                        onTap: () {
                          selectedCategoryStars = <String>[];
                          selectedCategoryStars.add(stars5);
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 12.0),
                          decoration: BoxDecoration(
                            color: selectedCategoryStars.contains(stars5)
                                ? Colors.blue[100]
                                : Colors.grey[300],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(48.0)),
                          ),
                          child: const CustomText(
                            text: "5 звезды",
                            align: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 2.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, bottom: 25, top: 30),
              child: const CustomText(
                text: "Предпочтение кровати",
                fontWeight: FontWeight.bold,
                size: 22,
                align: TextAlign.start,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const SizedBox(
                  width: 2.0,
                ),
                InkWell(
                  splashColor: Colors.blue[100],
                  onTap: () {
                    selectedCategoryBed = <String>[];
                    selectedCategoryBed.add(bed1);
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: selectedCategoryBed.contains(bed1)
                          ? Colors.blue[100]
                          : Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(48.0)),
                    ),
                    child: const CustomText(
                      text: "Односпальная кровать",
                      align: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 2.0,
                ),
                InkWell(
                  splashColor: Colors.blue[100],
                  onTap: () {
                    selectedCategoryBed = <String>[];
                    selectedCategoryBed.add(bed2);
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: selectedCategoryBed.contains(bed2)
                          ? Colors.blue[100]
                          : Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(48.0)),
                    ),
                    child: const CustomText(
                      text: "Двуспальная кровать",
                      align: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 2.0,
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(
                    left: 30, right: 30, top: 50, bottom: 50),
                width: double.infinity,
                height: 50,
                color: Colors.blue,
                child: const Center(
                  child: CustomText(
                    text: "Применить метрики",
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
