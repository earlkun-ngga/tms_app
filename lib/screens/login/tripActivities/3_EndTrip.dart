import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/screens/login/dashboard/dashboard.dart';
import 'package:tms_app_mobile/screens/template/screens/PurchaseButton.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';



class EndTripStep extends StatelessWidget{
 
  @override
  Widget build(BuildContext context) {
    return  Stack(
          children: [
            
            SizedBox(
              width: context.width(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                         ListTile(
                           title: Text('ANDA KEMBALI DI TEMPAT',
                           style: TextStyle(
                             fontWeight: FontWeight.bold
                           ),
                           ),
                         ),
                        ],
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        
                         Image.asset('assets/trip_img/10097.jpg'),
                         
                        ],
                      ),
                    ),
                
                  22.height,
                  
                   Container(
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        
                         ListTile(
                           
                           title: Text('Kumpulkan Dokumen : '),
                         ),
                         ListTile(
                           leading: Icon(Icons.document_scanner),
                           title: Text('Dokumen 1'),
                         ),
                         ListTile(
                           leading: Icon(Icons.document_scanner),
                           title: Text('Dokumen 2'),
                         ),
                        
                        ],
                      ),
                    ),
          
                ],
              ),
            ).paddingAll(16),
          ],
      
    );
  }
}
