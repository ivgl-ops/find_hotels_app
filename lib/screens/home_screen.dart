import 'package:find_hotels_app/view/start_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: (user == null) ? const LoginScreen() : StartView(index: 0),
        //child: Text('Контент для НЕ зарегистрированных в системе'),
      ),
    );
  }
}
