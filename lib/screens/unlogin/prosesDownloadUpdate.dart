import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ota_update/ota_update.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';



/// example widget for ota_update plugin
class UploadProcess extends StatefulWidget {
  @override
  _UploadProcessState createState() => _UploadProcessState();
  String urlDown;
  String newVersion;
  UploadProcess(this.urlDown, this.newVersion);
}

class _UploadProcessState extends State<UploadProcess> {
  OtaEvent? currentEvent;
  late double hash;

  @override
  void initState() {
    super.initState();
    tryOtaUpdate();
  }

  Future<void> tryOtaUpdate() async {
    try {
      //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
      OtaUpdate()
          .execute(
        '${widget.urlDown}',
        destinationFilename: 'KTMS_MOB_DRIVER.apk',
      )
      .listen(
        (OtaEvent event) {
          setState(() {
            currentEvent = event;
            hash = double.parse('${currentEvent?.value}')/100;

          } );
        },
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      print('Failed to make OTA update. Details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentEvent == null) {
      return Container();
    }
    return MaterialApp(
      home: Scaffold(
        backgroundColor: quiz_app_background,
      appBar: AppBar(
        title: Text(
          'K-TMS UPGRADE VERSION',
          style: primaryTextStyle(size: 18, fontFamily: "Medium"),
        ),
        
        centerTitle: true,
        backgroundColor: quiz_app_background,
        elevation: 0.0,
      ),
        body: Center(
          // child: Text('OTA status: ${currentEvent?.status} : ${currentEvent?.value} \n'),
          child: Center(child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center , crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Sedang Mengunduh', style: TextStyle(
                fontSize: 25.0
              ),),

              
             
              SizedBox(height: 20.0,),
              CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 10.0,
                  percent: this.hash,
                  center: new Text("${currentEvent?.value}%", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0
              ),),
                  progressColor: Colors.greenAccent,
                ),
                SizedBox(height: 20.0,),
                
                Chip(label:  Text('Versi : V.${widget.newVersion}', style: 
                TextStyle(
                color: Colors.white,
                fontSize: 15.0
                    ),
                    
                    ),
                    backgroundColor: Colors.grey,
                  ),



            ],
          ),
        ),)
      ),
    );
  }
}