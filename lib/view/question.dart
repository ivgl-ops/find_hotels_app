import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_hotels_app/view/list_hotels_view.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _currentQuestionIndex = 0;
  List search = [];

  void searchfromFirebase(
    String city,
    String places,
    String level_rooms,
    String location_type,
    String budget,
  ) async {
    final result = await FirebaseFirestore.instance
        .collection('hotels_ru')
        .where('city', isEqualTo: city)
        .where('places', isEqualTo: places)
        .where('level_rooms', isEqualTo: level_rooms)
        .where('location_type', isEqualTo: location_type)
        .where('budget', isEqualTo: budget)
        .get();

    setState(() {
      search = result.docs
          .map((doc) => {
                'id': doc.id,
                ...doc.data(),
              })
          .toList();
      print('count ${search.length}');
    });

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListHotelsView(
              isRec: true,
              city: city,
              places: places,
              level_rooms: level_rooms,
              location_type: location_type,
              budget: budget)),
    );

    print(search);
  }

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'В каком городе вы хотите остановиться?',
      'options': [
        'Москва',
        'Санкт-Петербург',
        'Краснодар',
        'Красноярск',
        'Владивосток',
      ]
    },
    {
      'question': 'Скольки местный отель вам нужен?',
      'options': [
        'Одноместный',
        'Двухместный',
        'Семейный',
      ]
    },
    {
      'question': 'Какой тип номера вы предпочитаете? ',
      'options': [
        'Cтандартный',
        'Люкс',
        'Номер повышенной комфортности',
      ]
    },
    {
      'question': 'Какое местоположение отеля вы предпочитаете?',
      'options': [
        'Центр города',
        'Рядом с аэропортом',
        'Туристическая часть',
        'Не важно'
      ]
    },
    {
      'question': 'Какой бюджет вы рассматриваете?',
      'options': ['Дешевый', 'Средний', 'Дорогой']
    }
  ];
  final List<Map<String, dynamic>> _answers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вопросы'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: CustomText(
                  text: _questions[_currentQuestionIndex]['question'],
                  size: 25,
                  fontWeight: FontWeight.bold,
                  align: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ),
            SizedBox(height: 50),
            Column(
              children: _questions[_currentQuestionIndex]['options']
                  .map<Widget>((option) => GestureDetector(
                        child: Container(
                          width: double.infinity,
                          margin:
                              EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          height: 50,
                          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(25)),
                          child: Center(
                            child: CustomText(
                              text: option,
                              size: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              align: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        onTap: () {
                          // Сохранить ответ пользователя на вопрос
                          _answers.add({
                            'question': _questions[_currentQuestionIndex]
                                ['question'],
                            'answer': option
                          });
                          _goToNextQuestion();
                        },
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _goToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      searchfromFirebase(_answers[0]['answer'], _answers[1]['answer'],
          _answers[2]['answer'], _answers[3]['answer'], _answers[4]['answer']);

      Future.delayed(Duration(seconds: 3), () {});
    }
  }
}
