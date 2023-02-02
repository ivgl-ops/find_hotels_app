import 'package:find_hotels_app/firebase/get_hotels.dart';
import 'package:find_hotels_app/view/calendar_view.dart';
import 'package:find_hotels_app/view/main_view.dart';
import 'package:find_hotels_app/view/num_person_view.dart';
import 'package:find_hotels_app/viewModel/num_person_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
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
        ChangeNotifierProvider(create: (context) => NumPersonViewModel())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/num': (context) => const NumPersonView(),
          '/main': (context) => const MainView()
        },
        home: const MainView(),
      ),
    );
  }
}
