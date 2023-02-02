import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      this.size,
      this.fontWeight,
      this.align,
      this.color,
      this.underline});

  final TextAlign? align;
  final Color? color;
  final FontWeight? fontWeight;
  final double? size;
  final String text;
  final TextDecoration? underline;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: align,
        style: GoogleFonts.montserrat(
          fontSize: size,
          fontWeight: fontWeight,
          color: color,
          decoration: underline,
        ));
  }
}
