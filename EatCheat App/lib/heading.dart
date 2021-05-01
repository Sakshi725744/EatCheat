import 'package:flutter/material.dart';
import 'package:frizzy/sizeconfig.dart';
import 'package:frizzy/gradientText.dart';

class headingGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double h = SizeConfig.safeBlockVertical * 100;
    double w = SizeConfig.safeBlockHorizontal * 100;
    return GradientText('EatCheat',
        gradient: LinearGradient(colors: [
          Color(0xff218588),
          Color(0xff40E0D0),

        ]),
        );
  }
}

