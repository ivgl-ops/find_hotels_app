import 'package:find_hotels_app/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScreenUser extends StatefulWidget {
  const ScreenUser({Key? key}) : super(key: key);

  @override
  State<ScreenUser> createState() => _ScreenUserState();
}

class _ScreenUserState extends State<ScreenUser> {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    final navigator = Navigator.of(context);

    await FirebaseAuth.instance.signOut();

    navigator.pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => signOut(),
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                CustomText(
                  text: user?.email ?? 'Профиль',
                  fontWeight: FontWeight.bold,
                  size: 25,
                ),
                SizedBox(
                  height: 80,
                ),
                buildMenuItem('Политика конфиденциальности'),
                buildMenuItem('Оплата'),
                buildMenuItem('Настройки'),
                Spacer(),
                GestureDetector(
                  onTap: () => signOut(),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.only(bottom: 50),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: CustomText(
                        text: 'Выйти',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(String text) {
    return Column(
      children: [
        Divider(),
        SizedBox(
          height: 8,
        ),
        CustomText(text: text),
        SizedBox(
          height: 8,
        ),
        Divider(),
      ],
    );
  }
}
