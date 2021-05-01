import 'dart:async';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/gestures.dart';
import '../headingWhite.dart';
import '../sizeconfig.dart';
import 'Authservice.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String phoneNo, verificationId, smsCode;
  bool inprogress = false; //to showcase loading state
  bool codeSent = false; //manage state until OTP sent
  showAlertDialog(BuildContext context, String error,String title) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {Navigator.of(context).pop();},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title,style: TextStyle(color: Theme.of(context).primaryColor),),
      content: Text(error),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double h = SizeConfig.safeBlockVertical*100;
    double w = SizeConfig.safeBlockHorizontal*100 ;
    var pageindicatorOTP = Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.1, vertical: h * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: h * (0.015),
            width: w * (0.2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20.0), right: Radius.circular(20.0)),
              color: Color(0xffE1E1E1),
            ),
          ),
          Container(
            height: h * (0.015),
            width: w * (0.20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20.0), right: Radius.circular(20.0)),
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            height: h * (0.015),
            width: w * (0.2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20.0), right: Radius.circular(20.0)),
              color: Color(0xffE1E1E1),
            ),
          )
        ],
      ),
    );
    var pageindicatorMobile = Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.1, vertical: h * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: h * (0.015),
            width: w * (0.2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20.0), right: Radius.circular(20.0)),
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            height: h * (0.015),
            width: w * (0.20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20.0), right: Radius.circular(20.0)),
              color: Color(0xffE1E1E1),
            ),
          ),
          Container(
            height: h * (0.015),
            width: w * (0.2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20.0), right: Radius.circular(20.0)),
              color: Color(0xffE1E1E1),
            ),
          )
        ],
      ),
    );
    var otp_text = Padding(
        padding: EdgeInsets.only(left: w * (0.05), right: w * (0.05), top: 10),
        child: PinCodeTextField(
          appContext: context,
          pastedTextStyle: GoogleFonts.varelaRound(
              textStyle: TextStyle(
                  color:Color(0xfff98f45),
                  fontSize: h*0.032,
                  fontWeight: FontWeight.bold)),
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          validator: (val) {
            if (val.length != 6) {
              return "Please enter 6 digit OTP";
            } else if (!val.contains(RegExp(r'^[0-9]*$'))) {
              return "Please enter numbers from 0-9";
            }
            return null;
          },
          pinTheme: PinTheme(
            selectedColor: Colors.white,
            activeColor: Colors.white,
            inactiveColor: Colors.white,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
            shape: PinCodeFieldShape.box,
            fieldHeight: h * (0.08),
            fieldWidth: w * (0.125),
            borderRadius: BorderRadius.circular(8),
          ),
          cursorColor: Theme.of(context).primaryColor,
          animationDuration: Duration(milliseconds: 300),
          textStyle: GoogleFonts.varelaRound(
              textStyle: TextStyle(
                  color:Color(0xfff98f45),
                  fontSize: h*0.034,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          keyboardType: TextInputType.number,
          boxShadows: [
            BoxShadow(
              offset: Offset(0, 1),
              color: Colors.black12,
              blurRadius: 10,
            )
          ],
          onCompleted: (v) {
            print("Completed");
          },
          onChanged: (value) {
            print(value);
            setState(() {
              this.smsCode = value;
            });
          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
          },
        ));
    var numfield = Padding(
        padding: EdgeInsets.only(left: w * (0.05), right: w * (0.05), top: 10),
        child: Card(
          elevation: 7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22.0)),
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            cursorColor: Theme.of(context).primaryColor,
            maxLength: 10,
            maxLengthEnforced: true,
            textAlign: TextAlign.center,
            validator: (value) {
              if (value.length < 10) {
                return 'Please enter 10 digit number ';
              } else if (!value.contains(RegExp(r'^[0-9]*$'))) {
                return "Please enter numbers from 0-9";
              }
              return null;
            },
            decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              counterStyle: TextStyle(
                height: double.minPositive,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
            style: GoogleFonts.varelaRound(
                textStyle: TextStyle(
                    color: Color(0xfff98f45),
                    fontSize: h*0.032,
                    fontWeight: FontWeight.bold)),
            //decoration: InputDecoration(hintText: 'Enter phone number'),
            onChanged: (val) {
              setState(() {
                this.phoneNo = "+91" + val;
              });
            },
          ),
        ));
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,

          colors: [
            Color(0xff40E0D0),
            Color(0xff218588),

          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        //backgroundColor: Color(0xfff7f7f7),
        body: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(w * 0.15),
                  child: Center(child: headingWhite()),
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * (0.07), top: (h * 0.1)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: codeSent
                        ? Text("Enter OTP sent to your mobile number",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: h*0.029,
                            ))
                        : Text("Enter mobile number and Login",
                            textAlign: TextAlign.left,
                            style:TextStyle(
                              color: Colors.white,
                              fontSize: h*0.029,
                            )),
                  ),
                ),
                codeSent
                    ? (inprogress
                        ? Padding(
                            padding: EdgeInsets.all(w * 0.05),
                            child: CircularProgressIndicator(),
                          )
                        : otp_text)
                    : (inprogress
                        ? Padding(
                            padding: EdgeInsets.all(w * 0.05),
                            child: CircularProgressIndicator(),
                          )
                        : numfield),
                codeSent
                    ? Padding(
                        padding: EdgeInsets.only(top: h * 0.06, bottom: h * 0.03),
                        child: Column(children: [
                          InkWell(
                            child: Text("Resend OTP",
                                style: TextStyle(
                                    color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  fontSize: h*0.022,
                                  fontWeight: FontWeight.bold
                                )),
                            onTap: () {
                              verifyPhone(phoneNo);
                            },
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          InkWell(
                            child: Text("Change Mobile Number",
                                style:TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  fontSize: h*0.022,
                                    fontWeight: FontWeight.bold
                                )),
                            onTap: () {
                              setState(() {
                                inprogress=false;
                                codeSent = false;
                              });
                            },
                          ),
                        ]),
                      )
                    : SizedBox(
                        height: h * 0.15,
                      ),
                Padding(
                    padding: EdgeInsets.only(
                        // top: h * 0.10,
                        ),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(w * 0.15),
                            side: BorderSide(color: Color(0xff704629), width: 1)),
                        child: Container(
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w * 0.15, vertical: h * 0.015),
                                child: Text(
                                  'NEXT',
                                  style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: h*0.04,
                                  ),
                                ))),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            setState(() {
                              inprogress = true;
                            });
                            codeSent
                                ? signInWithOTP(smsCode, verificationId)
                                : verifyPhone(phoneNo);
                          }
                        })),
              ],
            )),
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
          setState(() {
            inprogress=false;
          });
      showAlertDialog(context, authException.message,"Phone Number Error!");
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
        this.inprogress = false;
        var snackBar = SnackBar(
          content: Text(
            "OTP sent to " + phoneNo,
            textAlign: TextAlign.center,
            style:  TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(milliseconds: 1500),
        );
        scaffoldKey.currentState.showSnackBar(snackBar);
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  Future<void> signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.credential(
        verificationId: verId, smsCode: smsCode);
    FirebaseAuth.instance.signInWithCredential(authCreds).catchError((error) {
      setState(() {
       inprogress=false;

      });
      return showAlertDialog(context, "Please enter the OTP sent to "+phoneNo+" OR tap Resend OTP","Incorrect OTP!");
    });
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }
}
