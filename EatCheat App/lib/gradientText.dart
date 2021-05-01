import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frizzy/sizeconfig.dart';

class GradientText extends StatelessWidget {
  GradientText(
      this.text, {
        this.gradient,
      });

  final String text;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double h = SizeConfig.safeBlockVertical * 100;
    double w = SizeConfig.safeBlockHorizontal * 100;
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
          style: GoogleFonts.sedgwickAveDisplay(
              textStyle: TextStyle(
                color: Colors.white,
                  fontSize: h * 0.07,
                  fontWeight: FontWeight.bold)),
      ),
    );
  }
}