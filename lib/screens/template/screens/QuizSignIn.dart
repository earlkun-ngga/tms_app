import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:http/http.dart' as http;
import 'package:tms_app_mobile/models/SessionUser_model.dart';
import 'package:tms_app_mobile/screens/login/dashboard/dashboard.dart';
import 'package:tms_app_mobile/config/apiConfig.dart' as apiconf;
import '../utils/AppWidget.dart';
import '../utils/QuizColors.dart';
import '../utils/QuizConstant.dart';
import '../utils/QuizStrings.dart';
import '../utils/QuizWidget.dart';

class QuizSignIn extends StatefulWidget {
  static String tag = '/QuizSignIn';

  @override
  _QuizSignInState createState() => _QuizSignInState();
}

class _QuizSignInState extends State<QuizSignIn> {

  TextEditingController usernameCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  SessionUser sesusr = SessionUser();


  @override
  Widget build(BuildContext context) {
    changeStatusColor(quiz_app_background);

    return Scaffold(
      backgroundColor: quiz_app_background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: quiz_app_background,
            child: Column(
              children: <Widget>[
                SizedBox(height: 16),
                text('KTMS APP', fontSize: 50.0, fontFamily: fontBold),
                text('DRIVER', textColor: quiz_textColorSecondary, isLongText: true, isCentered: true).center(),
                Container(
                  margin: EdgeInsets.all(24.0),
                  decoration: boxDecoration(bgColor: quiz_white, color: quiz_white, showShadow: true, radius: 10),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: usernameCont,
                          style: TextStyle(fontSize: textSizeMedium, fontFamily: fontRegular),
                          obscureText: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 22, 16, 22),
                            hintText: 'Username',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: quiz_textColorSecondary),
                          ),
                        ),
                      quizDivider(),
                       TextFormField(
                         controller: passwordCont,
                          style: TextStyle(fontSize: textSizeMedium, fontFamily: fontRegular),
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 22, 16, 22),
                            hintText: 'Password',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: quiz_textColorSecondary),
                          ),
                        ),
                     
                    ],
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.all(24.0),
                    child: quizButton(
                        textContent: 'LOGIN',
                        onPressed: () {
                          setState(() async {
                            buatLoadingLogin(context);
                            final response = await http.post(Uri.parse('${apiconf.urlApi}api/mobile-login'),
                            body: {
                                "username": usernameCont.text, 
                                "password": passwordCont.text
                              }
                            );
                            final datacheck = json.decode(response.body);
                            print(response.statusCode);
                            // print(datacheck);
                            if(response.statusCode == 200)
                            {
                            sesusr.setUsernameUserSF('${usernameCont.text}');
                            sesusr.setPasswordUserSF('${passwordCont.text}');
                            Navigator.of(context).pop(); // POP Loading
                            Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => Dashboard(),
                                ),
                                (route) => false,);
                            } 
                            else 
                            // Gagal Login !!!
                            {
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => new AlertDialog(
                                  title: new Text('Gagal'),
                                  content: new Text('Username atau Password, Salah !!!'),
                                  actions: <Widget>[
                                    new IconButton(
                                        icon: new Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                ));
                                  }



                          });
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

 buatLoadingLogin(BuildContext context) {
    return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Center(
                  child: CircularProgressIndicator(
                 backgroundColor: Color(0xFFACB5FD),
                    color: Color(0xFFf3f5f9),
                  ),);});
  }
