import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
// import 'package:quiz_flutter/Screens/PurchaseMoreScreen.dart';
// import 'package:quiz_flutter/Screens/QuizSettings.dart';
import '../model/QuizModels.dart';
import '../utils/AppWidget.dart';
import '../utils/QuizColors.dart';
import '../utils/QuizConstant.dart';
import '../utils/QuizDataGenerator.dart';
import '../utils/QuizImages.dart';
import '../utils/QuizStrings.dart';

class QuizProfile extends StatefulWidget {
  static String tag = '/QuizProfile';

  @override
  _QuizProfileState createState() => _QuizProfileState();
}

class _QuizProfileState extends State<QuizProfile> {
  late List<QuizBadgesModel> mList;
  late List<QuizScoresModel> mList1;

  int selectedPos = 1;

  @override
  void initState() {
    super.initState();
    selectedPos = 1;
    mList = quizBadgesData();
    mList1 = quizScoresData();
  }

  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: Scaffold(
      backgroundColor: quiz_app_background,
       appBar: AppBar(
        title: Text(
          'Scan Barcode Absent and Get car',
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
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            
      color: quiz_app_background, 
      child: Container(
      color: quiz_app_background,
      child: Column(
        children: <Widget>[


           Container(
            margin: const EdgeInsets.only(left:30, right: 30, top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center , crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Silahkan Pilih mobil / truck, lalu scan barcode yang tertera di mobil / truck',
              style: TextStyle(
                color: quiz_textColorPrimary,
                fontSize: 15.0
              ),
              )
            ],
          ) ,),
          SizedBox(height: 10),
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 2,
                margin: const EdgeInsets.only(left:20, right: 20, top: 30),
                decoration: BoxDecoration(shape: BoxShape.rectangle, border: Border.all(color: quiz_white, width: 4)),
                child:  Image.asset('assets/gif/scan_fif.gif',
                             height: MediaQuery.of(context).size.width * 0.3, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,
                            )
              ),
            
            ],
          ),
         
          
          
         
            
              
        ],
      ),
    ).center()
          
          
          
          
          ),
        ),
        
        bottomNavigationBar:  Material(
        color: quiz_colorPrimary,
        child: InkWell(
          onTap: () {
            print('called on tap');
          },
          child: const SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                'SCAN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}
