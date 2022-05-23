
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/models/SessionUser_model.dart';
import 'package:tms_app_mobile/models/Version_model.dart';
import 'package:tms_app_mobile/screens/login/dashboard/dashboard.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/config/apiConfig.dart' as apiConf;
// import 'PurchaseMoreScreen.dart';


class Settings extends StatefulWidget {
  static String tag = '/QuizSetting';
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {



  

  bool langBool = false;
  Version ver = Version();
  SessionUser sesusr = SessionUser();
  String valBahasa = '';

  @override
  void initState() {
    // TODO: implement initState

    sesusr.getLanguageCode().then((value) => {
      setState((){
        this.valBahasa = value;
      })
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(quiz_app_background);
    return RefreshIndicator(
      
      child: SafeArea(
      child: Scaffold(
      backgroundColor: quiz_app_background,
      appBar: AppBar(
        title: Text(
          'settings.tittle'.tr(),
          style: primaryTextStyle(size: 18, fontFamily: "Medium"),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: quiz_colorPrimary,
          size: 30,
        ).onTap(() {
          Navigator.of(context).pop();
        }),
        centerTitle: true,
        backgroundColor: quiz_app_background,
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          
                          ListTile(
                          leading: Icon(Icons.flag, color: Colors.orangeAccent,),
                          title: Text('settings.bahasa'.tr(), style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: InkWell(child: 
                          (this.langBool == false) ?
                          Icon(Icons.arrow_downward) : 
                          Icon(Icons.arrow_upward)
                          ),
                          onTap: () {
                            if(this.langBool == false){
                              setState(() {
                                this.langBool = true;
                              });
                            } else {
                              setState(() {
                                this.langBool = false;
                              });
                            }
                          },
                         ),
                         (this.langBool == true) ?
                         Column(
                           children: [
                              ListTile(
                              title: Text('INDONESIA'),
                              trailing: InkWell(child: (this.valBahasa == '1') ? Icon(Icons.radio_button_on) : Icon(Icons.radio_button_off)),
                              onTap: ()  {
                                print('Pilih Bahasa Indonesia !!!');
                                buatLoadingGantiBahasa(context);
                                sesusr.setLanguageCode('1');
                                Navigator.pushAndRemoveUntil<dynamic>(
                                                        context,
                                                        MaterialPageRoute<dynamic>(
                                                          builder: (BuildContext context) => Dashboard(),
                                                        ),
                                                        (route) => false,);
                              },
                            ),
                              ListTile(
                              title: Text('ENGLISH'),
                              trailing: InkWell(child: (this.valBahasa == '2') ? Icon(Icons.radio_button_on) : Icon(Icons.radio_button_off),),
                              onTap: () {
                                print('Choice English Language !!!');
                                buatLoadingGantiBahasa(context);
                                sesusr.setLanguageCode('2');
                                Navigator.pushAndRemoveUntil<dynamic>(
                                                        context,
                                                        MaterialPageRoute<dynamic>(
                                                          builder: (BuildContext context) => Dashboard(),
                                                        ),
                                                        (route) => false,);
                              },
                            ),
                           ],
                         ) : Container(),
                         
                        ],
                      ),
                    ),
                
                    Container(
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: <Widget>[
                        
                        ],
                      ),
                    ),
                      Chip(
                        label: Text('Version Number :  ${ver.currentVersion}', style: TextStyle(
                        color: Colors.white, 
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                        ),),
                        backgroundColor: Colors.grey[30],
                      ),
                      Chip(
                        label: Text('Server URL :  ${apiConf.urlApi}', style: TextStyle(
                        color: Colors.white, 
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                        ),),
                        backgroundColor: Colors.grey[30],
                      ),
                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      )), onRefresh: () async {
        print('OKE !!!');
    });
  }
}

Widget quizSettingOptionPattern1(var settingIcon, var heading, var info) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: quiz_color_setting),
              width: 45,
              height: 45,
              padding: EdgeInsets.all(4),
              child: Icon(
                settingIcon,
                color: quiz_white,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(heading),
                Text(
                  info,
                  style: primaryTextStyle(color: quiz_textColorSecondary, size: 14),
                )
              ],
            ),
          ],
        ),
        Icon(
          Icons.keyboard_arrow_right,
          color: quiz_icon_color,
        )
      ],
    ),
  );
}

Widget quizSettingOptionPattern2(var icon, var heading) {
  bool isSwitched1 = false;
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: quiz_color_setting),
              width: 45,
              height: 45,
              padding: EdgeInsets.all(4),
              child: Icon(
                icon,
                color: quiz_white,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Text(heading),
          ],
        ),
       
      ],
    ),
  );
}

buatLoadingGantiBahasa(BuildContext context) {
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


