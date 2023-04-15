import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color bgColor = const Color(0xFFFFFDFD);
Color sparatorColor = const Color(0xFFF5F4F4);
Color gray = const Color(0xFFE7E7E7);
Color grayText = const Color(0xFFBDBDBD);
Color purple1 = const Color(0xFF4F3A57);
Color purple2 = const Color(0xFFBB6BD9);
Color purpleLight = const Color(0xFFF7E3FF);
Color green = const Color(0xFF6FCF97);
Color greenLight = const Color(0XFFD8FFE8);
Color yellowLight = const Color(0xFFFFF7DF);
Color blueLight = const Color(0xFFDEF7FF);
Color labelColor = const Color(0xFF485465);
Color red = const Color(0xFFEB5757);
Color blueChill = const Color.fromRGBO(21, 152, 149, 1);
Color fountainBlue = const Color.fromRGBO(87, 197, 182, 1);

TextStyle textBold = GoogleFonts.openSans()
    .copyWith(fontWeight: FontWeight.bold, fontSize: 24, color: purple1);

TextStyle textBold2 = GoogleFonts.poppins().copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 10,
  color: grayText,
  letterSpacing: 6 / 100,
);

TextStyle textBold3 = GoogleFonts.openSans().copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: green,
);

TextStyle textSemiBold = GoogleFonts.openSans()
    .copyWith(fontWeight: FontWeight.w600, fontSize: 13, color: purple1);

TextStyle label = GoogleFonts.openSans()
    .copyWith(fontWeight: FontWeight.w400, fontSize: 11, color: labelColor);

TextStyle headerUser = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.w600, fontSize: 18, color: purple1);

TextStyle titleHeader = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.w400, fontSize: 16, color: purple1);

TextStyle cartName = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.w600, fontSize: 16, color: purple1);

TextStyle cartEmail = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.w400, fontSize: 14, color: purple1);

TextStyle cartTag = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: bgColor);

TextStyle textMonster = GoogleFonts.ubuntu()
    .copyWith(fontWeight: FontWeight.w700, fontSize: 25, color: Colors.black);
