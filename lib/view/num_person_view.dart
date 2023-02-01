import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NumPersonView extends StatefulWidget {
  const NumPersonView({super.key});

  @override
  State<NumPersonView> createState() => _NumPersonViewState();
}

class _NumPersonViewState extends State<NumPersonView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimateGradient(
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: const [Color(0XFF007AFF), Color(0xffFF001F)],
        secondaryColors: const [
          Colors.blueAccent,
          Colors.blue,
        ],
        child: Container(
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
