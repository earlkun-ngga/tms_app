import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/screens/template/screens/QuizSettings.dart';
// import 'package:quiz_flutter/Screens/QuizDetails.dart';
// import 'package:quiz_flutter/Screens/QuizNewList.dart';
// import 'package:quiz_flutter/Screens/QuizSearch.dart';
import '../model/QuizModels.dart';
import '../utils/AppWidget.dart';
import '../utils/QuizColors.dart';
import '../utils/QuizConstant.dart';
import '../utils/QuizDataGenerator.dart';
import '../utils/QuizStrings.dart';
import '../utils/QuizWidget.dart';

class QuizHome extends StatefulWidget {
  static String tag = '/QuizHome';

  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  late List<NewQuizModel> mListings;

  @override
  void initState() {
    super.initState();
    mListings = getQuizData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: quiz_app_background,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start , crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.only(left: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start, 
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      text(quiz_lbl_hi_antonio, fontFamily: fontBold, fontSize: textSizeXLarge),
                      text(quiz_lbl_what_would_you_like_to_learn_n_today_search_below, textColor: quiz_textColorSecondary, isLongText: true, isCentered: true),
                    ],)

                  ),
                  
                  SizedBox(height: 30),
                  SizedBox(
                    //height: MediaQuery.of(context).size.width * 0.8,
                    height: 240,
                child: Container(
                  margin: const EdgeInsets.only(left:20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: boxDecoration(radius: 16, showShadow: true, bgColor: quiz_white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                            child: CachedNetworkImage(placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?, imageUrl: 'https://assets.iqonic.design/old-themeforest-images/prokit/images/quiz/quiz_ic_communication.png', height: MediaQuery.of(context).size.width * 0.3, width: MediaQuery.of(context).size.width, fit: BoxFit.cover),
                          ),
                        ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  text('January 2022', fontFamily: fontBold, fontSize: textSizeXLarge),
                  text('101 Trips', textColor: quiz_textColorSecondary, isLongText: true, isCentered: true),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
                  ).paddingOnly(bottom: 14),
                   Container(
                     margin: const EdgeInsets.only(left:20, right: 20),
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            child: Padding(
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
                                            Icons.scanner,
                                            color: quiz_white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text('ABSEN AND GET CAR',
                                        style: TextStyle(
                                          color: quiz_textColorPrimary,
                                          fontSize: 20.0
                                        ),
                                        ),
                                      ],
                                    ),
                                            Icon(
                                              Icons.keyboard_arrow_right,
                                              color: quiz_icon_color,
                                            )
                                  
                                  ],
                                ),
                          ),
                          onTap: () {
                            print('scan');
                          },
                          )
                          
                        ],
                      ),
                    ),

                    SizedBox(height: 10.0,),
                    SizedBox(height: 10.0,),

                  Container(
                    margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('MENU', style: TextStyle(color: quiz_textColorSecondary)),
                      Divider(),
                    ],
                  ),
                  ),
                  SizedBox(height: 10.0,),

                    Row(
                      children: [
                        Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left:20),
                      
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            child:  quizSettingOptionPattern2(Icons.star, 'Absen'),
                            onTap: () {
                              print('Menu ke 1');
                            },
                          ),
                         
                          InkWell(
                            child:  quizSettingOptionPattern2(Icons.star, 'Absen'),
                            onTap: () {
                              print('Menu ke 2');
                            },
                          ),
                        ],
                      ),
                    )),
                    VerticalDivider(),
                    Expanded(
                      child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            child:  quizSettingOptionPattern2(Icons.star, 'Absen'),
                            onTap: () {
                              print('Menu ke 3');
                            },
                          ),
                          InkWell(
                            child:  quizSettingOptionPattern2(Icons.star, 'Absen'),
                            onTap: () {
                              print('Menu ke 4');
                            },
                          ),
                        ],
                      ),
                    )),

                      ],
                    )

                    

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class NewQuiz extends StatelessWidget {
  late NewQuizModel model;

  NewQuiz(NewQuizModel model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(left: 16),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: boxDecoration(radius: 16, showShadow: true, bgColor: quiz_white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                child: CachedNetworkImage(placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?, imageUrl: model.quizImage, height: w * 0.4, width: MediaQuery.of(context).size.width * 0.75, fit: BoxFit.cover),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    text(model.quizName, fontSize: textSizeMedium, isLongText: true, fontFamily: fontMedium, isCentered: false),
                    text(model.totalQuiz, textColor: quiz_textColorSecondary),
                  ],
                ),
                Icon(Icons.arrow_forward, color: quiz_textColorSecondary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
