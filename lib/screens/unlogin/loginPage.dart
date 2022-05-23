import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/models/SessionUser_model.dart';
import 'package:tms_app_mobile/models/UserDriver_model.dart';
import 'package:tms_app_mobile/models/Version_model.dart';
import 'package:tms_app_mobile/screens/login/dashboard/dashboard.dart';
import '../template/utils/AppWidget.dart';
import '../template/utils/QuizColors.dart';
import '../template/utils/QuizConstant.dart';
import '../template/utils/QuizWidget.dart';

class LoginPage extends StatefulWidget {
  static String tag = '/QuizSignIn';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool obsecure = true;

  TextEditingController usernameCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  SessionUser sesusr = SessionUser();
  UserDriver userdriver = UserDriver();
  Version ver = Version();
  @override
  Widget build(BuildContext context) {
    changeStatusColor(quiz_app_background);
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7,
                  ),
                
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center , crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                text(' K-TMS APP', fontSize: 40.0, fontFamily: fontBold),
                ],),
                text('FOR DRIVER', textColor: quiz_textColorSecondary, isLongText: true, isCentered: true).center(),
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
                            hintText: 'User ID',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: quiz_textColorSecondary),
                          ),
                        ),
                      quizDivider(),
                      
                      Row(children: [

                        Expanded(
                          flex: 8,
                          child: 

                           TextFormField(
                         controller: passwordCont,
                          style: TextStyle(fontSize: textSizeMedium, fontFamily: fontRegular),
                          obscureText: this.obsecure,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 22, 16, 22),
                            hintText: 'Password',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: quiz_textColorSecondary),
                          ),
                        ),
                        
                        ),

                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                     
                              if(this.obsecure == true)
                              {
                                setState(() {
                                this.obsecure = false;
                              });
                              } else {

                                setState(() {
                                  this.obsecure = true;
                                });
                              }
                              
                            },
                            child: Container(
                              child: (this.obsecure == true) ? 
                              Icon(Icons.visibility_off, color: Colors.grey) 
                              : 
                              Icon(Icons.visibility, color: Colors.grey)
                              ),
                            ),
                          ),
                      ],)],
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(height: 10),
                Container(
                    margin: EdgeInsets.all(24.0),
                    child: quizButton(
                        textContent: 'LOGIN',
                        onPressed: () {
                          setState(() async {
                            buatLoadingLogin(context);
                            var respApi = await userdriver.prosesLoginV1(usernameCont.text, passwordCont.text);// POP Loading
                            var dataapi = json.decode(respApi.body);
                            print(respApi.statusCode);
                            if(respApi.statusCode == 200)
                            {
                              if(dataapi['data']['driver'] == null) {
                                  Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => new AlertDialog(
                                  title: new Text('Gagal'),
                                  content: new Text('Bukan Akun Driver !'),
                                  actions: <Widget>[
                                    new IconButton(
                                        icon: new Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                ));


                              } else {
                                print('Login Berhasil !!!');
                                sesusr.setUsernameUserSF('${usernameCont.text}');
                                sesusr.setPasswordUserSF('${passwordCont.text}');
                                sesusr.setDriverId('${dataapi['data']['driver']['id']}');
                                Navigator.of(context).pop(); // POP Loading
                                Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => Dashboard(),
                                ),
                                (route) => false,);
                              }
                            } else {
                              print('Login Gagal !!!');
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
                        })),
                        SizedBox(height: 30),
                        SizedBox(height: 10),
                      Chip(label: Text('V. ${ver.currentVersion}', style: TextStyle(
                        color: Colors.white, 
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                        ),),
                        backgroundColor: Colors.grey[30],)
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
