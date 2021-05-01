
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frizzy/MobileAuth/Authservice.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          accentColor: Colors.white,
          buttonColor: Color(0xff00A9A9),
          primaryColor: Color(0xfff98f45),
          textTheme: GoogleFonts.gfsNeohellenicTextTheme(
            Theme.of(context).textTheme,
          )),

      home: AuthService().handleAuth(),
    );
  }
}
