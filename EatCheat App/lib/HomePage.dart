import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frizzy/heading.dart';
import 'package:frizzy/sizeconfig.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int toggle = 0;
  @override
  Widget build(BuildContext context) {
    double h = SizeConfig.safeBlockVertical * 100;
    double w = SizeConfig.safeBlockHorizontal * 100;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: w * 0.05,right: w * 0.05 ,top: h * 0.07,bottom:h * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headingGradient(),
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Theme.of(context).primaryColor,
                    ),
                    iconSize: 40,
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                  )
                ],
              ),
            ),
            ToggleSwitch(
              minWidth: w * 0.3,
              minHeight: h* 0.06,
              fontSize: h*0.025,
              iconSize: h*0.03,
              initialLabelIndex: toggle,
              cornerRadius: 10.0,
              changeOnTap: true,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              labels: ['Cooked', 'Processed'],
              icons: [FontAwesomeIcons.cameraRetro, FontAwesomeIcons.barcode],
              activeBgColors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor],
              onToggle: (index) {
                print(toggle.toString());
                setState(() {
                  toggle=index;
                });
              },
            ),
            SizedBox(height: h*0.07,),
            Expanded(
            child: Container()
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15),
                  child: Text(
                    "On pressing the Camera/Barcode button \n live data of the food with expiry \n will be sent to the app",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),

                ),
              ),

          ],
        ));
  }
}
