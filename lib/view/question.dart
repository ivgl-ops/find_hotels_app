import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _currentQuestionIndex = 0;
  List search = [];

  void searchfromFirebase(String location, String location_type) async {
    final result = await FirebaseFirestore.instance
        .collection('hotels_ru')
        .where('location', isEqualTo: location)
        .where('location_type', isEqualTo: location_type)
        .get();

    setState(() {
      search = result.docs
          .map((doc) => {
                'id': doc.id,
                ...doc.data(),
              })
          .toList();
    });
  }

  final List<Map<String, dynamic>> _questions = [
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
      'question':
          'Хотели бы вы остановиться в отеле с видом на парк, реку или городской пейзаж?',
      'options': ['парк', 'реку', 'городской пейзаж']
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
            Text(
              _questions[_currentQuestionIndex]['question'],
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Column(
              children: _questions[_currentQuestionIndex]['options']
                  .map<Widget>((option) => ElevatedButton(
                        child: Text(option),
                        onPressed: () {
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
      searchfromFirebase(_answers[3]['answer'], _answers[2]['answer']);
      Future.delayed(Duration(seconds: 3), () {
        print(_answers[3]['answer']);
        print(search.length);
      });
    }
  }
}
