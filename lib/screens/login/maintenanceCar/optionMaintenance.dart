import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/screens/login/maintenanceCar/maintenanceListHistory/maintenanceListHistory.dart';
import 'package:tms_app_mobile/screens/login/maintenanceCar/step1ScanMaintenance.dart';
import 'package:tms_app_mobile/screens/login/settings/settings.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';




class OptionMaintenance extends StatelessWidget{
  late String idDriver;
  late String userId;
  OptionMaintenance(this.idDriver, this.userId);
  Widget build(BuildContext context) {
    changeStatusColor(quiz_app_background);
    return Scaffold(
      backgroundColor: quiz_app_background,
      appBar: AppBar(
        title: Text(
          'Maintenance',
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
      body: Column(
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
                          quizSettingOptionPattern1(Icons.engineering, 'Buat Maintenance', 'Untuk Mobil / Trailer').onTap(() {
                               Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => ScanMaintenance('${this.idDriver}', '${this.userId}')),
                                );
                          }),
                          quizSettingOptionPattern1(Icons.view_list, 'List Maintenance', 'Daftar Maintenance').onTap(() {
                              Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => MaintenanceListHistory('${this.idDriver}')),
                                );
                          }),
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
                   
                   
                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



}