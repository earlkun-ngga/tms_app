import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/screens/login/dashboard/dashboard.dart';
import 'package:tms_app_mobile/screens/template/screens/PurchaseButton.dart';

import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';

class SuccessInputMaintenance extends StatefulWidget {
  
  String idMaintenance;


  SuccessInputMaintenance(this.idMaintenance);

  @override
  _SuccessInputMaintenanceState createState() => _SuccessInputMaintenanceState();
}

class _SuccessInputMaintenanceState extends State<SuccessInputMaintenance> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Icon(Icons.arrow_back, size: 24).paddingAll(16).onTap(() {
              finish(context);
            }).visible(false),
            SizedBox(
              width: context.width(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Form Maintenance Sudah di buat. Maintenance Sedang di lakukan.',
                    style: boldTextStyle(size: 20),
                    textAlign: TextAlign.center,
                  ),
                   16.height,
                  Container(
                      child: Image.asset('assets/success/success_maintenance.png'),
                      height: 300.0,
                      ),
                  22.height,
                   Container(
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        
                         ListTile(
                           leading: Icon(Icons.stay_primary_landscape),
                           title: Row(children: [
                             Text('#IDM : ', style: TextStyle(fontWeight: FontWeight.bold),),
                             Text('${widget.idMaintenance}')
                           ],),
                         ),
                        
                        
                        ],
                      ),
                    ),
                 
                 
                 quizButton(
                        textContent: 'Kembali ke Dashboard',
                        onPressed: () {
                           Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => Dashboard(),
                                ),
                                (route) => false,);
                        })
                ],
              ),
            ).paddingAll(16),
          ],
        ),
      ),
    );
  }
}
