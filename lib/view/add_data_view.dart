import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddDataView extends StatefulWidget {
  const AddDataView({Key? key}) : super(key: key);

  @override
  State<AddDataView> createState() => _AddDataViewState();
}

class _AddDataViewState extends State<AddDataView> {
  void createDocuments() async {
    // Получаем ссылку на коллекцию в Firestore
    CollectionReference itemsRef =
        FirebaseFirestore.instance.collection('hotels_ru');
    List<String> city = [
      'Москва',
      'Новосибирск',
      'Сочи',
      'Красноярск',
      'Владивосток',
    ];
    List<String> img = [
      'https://www.atorus.ru/sites/default/files/upload/image/News/56149/Club_Privé_by_Belek_Club_House.jpg',
      'https://cdnn21.img.ria.ru/images/151472/35/1514723511_0:546:5244:3495_1920x0_80_0_0_b2e21246367c8a57294b5974a7809512.jpg',
      'https://turpotok.com/wp-content/uploads/2018/07/foto-otelya-atlantis-v-dubae-4.jpg',
      'https://welcome.mosreg.ru/cache/thumbs/thumb_1920__3555199304.jpg',
      'https://kuku.travel/wp-content/uploads/2018/08/Номер-в-отеле-Jumeirah-Beach.jpg',
      'https://s.101hotelscdn.ru/uploads/image/hotel_3/86859/36867425.jpg',
      'https://loukoster.com/wp-content/uploads/2021/10/273076965.jpg',
      'https://storage.googleapis.com/xo-ua/2022/02/7270febb-48761643.jpg'
    ];
    List<String> levelRooms = [
      'Cтандартный',
      'Люкс',
      'Номер повышенной комфортности'
    ];
    List<String> locationType = [
      'Центр города',
      'Рядом с аэропортом',
      'Туристическая часть',
      'Не важно'
    ];
    List<String> name = [
      "Оазисный дворец",
      "Золотая башня",
      "Лазурный пляж",
      "Серебряная гавань",
      " Райский уголок",
      "Экзотический курорт",
      "Вершинный вид",
      "Кристальный лагун",
      "Шик и роскошь",
      "Солнечный берег",
      "Ар-деко",
      "Ренессансный дворец",
      "Неоклассический отель",
      "Барочный дворец",
      "Арт-нуво отель",
      "Московский рай",
      "Питерская звезда",
      "Сибирская тайга",
      "Кавказский переулок",
      "Крымский бриз",
      "Белоснежный дворец",
      "Зеленый оазис",
      "Солнечная гавань",
      "Стальной форт",
      "Кристальный замок",
    ];

    List<String> place = [
      'Одноместный',
      'Двухместный',
      'Семейный',
    ];

    Random random = Random();

    // Создаем 100 документов в коллекции
    for (int i = 0; i < 500; i++) {

      int price = random.nextInt(4501) + 500;
      String budget = "";

      if (price < 1000) {
        budget = "Дешевый";
      } else if (price > 1000 && price < 2000) {
        budget = "Средний";
      } else {
        budget = "Дорогой";
      }
      String documentId = itemsRef.doc().id;
      await itemsRef.add({
        'ID': documentId,
        'budget': budget,
        // int
        'city': city[random.nextInt(city.length)],
        // string
        'img': img[random.nextInt(img.length)],
        // string
        'level_rooms': levelRooms[random.nextInt(levelRooms.length)],
        //bool
        'like': false,
        // string
        'location_type': locationType[random.nextInt(locationType.length)],
        // string
        'name': name[random.nextInt(name.length)],
        // string
        'places': place[random.nextInt(place.length)],
        // string
        'price': '$price',
        // string
        'rate': '${random.nextInt(8) + 3}',
        // string
      });
    }

    if (kDebugMode) {
      print('Документы успешно созданы!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(child: Text("Загрузить данные")),
        onTap: () {
          createDocuments();
        },
      ),
    );
  }
}
