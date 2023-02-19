import 'package:find_hotels_app/data/sort.dart';
import 'package:find_hotels_app/firebase/get_hotels.dart';
import 'package:find_hotels_app/view/filter_hotels_view.dart';
import 'package:find_hotels_app/view/list_hotels_view.dart';
import 'package:find_hotels_app/view/main_view.dart';
import 'package:find_hotels_app/view/num_person_view.dart';
import 'package:find_hotels_app/viewModel/num_person_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GetHotel()),
        ChangeNotifierProvider(create: (context) => NumPersonViewModel()),
        ChangeNotifierProvider(create: (context) => Sort())
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightBlueAccent,
        ),

        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ru'),
        ],
        title: 'Flutter Demo',
        routes: {
          '/num': (context) => const NumPersonView(),
          '/main': (context) => const MainView(),
          '/search': ((context) => const ListHotelsView()),
          '/filter': ((context) => const FilterHotelsView())
        },
        home: const MainView(),
      ),
    );
  }
}
