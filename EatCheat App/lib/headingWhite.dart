import 'package:flutter/material.dart';
import 'package:frizzy/sizeconfig.dart';
import 'package:frizzy/gradientText.dart';
import 'package:google_fonts/google_fonts.dart';

class headingWhite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double h = SizeConfig.safeBlockVertical * 100;
    double w = SizeConfig.safeBlockHorizontal * 100;
    return Text('EatCheat',
      style: GoogleFonts.sedgwickAveDisplay(textStyle:TextStyle(
          color: Colors.white,
          fontSize: h * 0.07,
          fontWeight: FontWeight.bold) ),
    );
  }
}

