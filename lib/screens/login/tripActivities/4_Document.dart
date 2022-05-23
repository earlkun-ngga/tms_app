import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/models/Trip_model.dart';
import 'package:tms_app_mobile/screens/login/dashboard/dashboard.dart';
import 'package:tms_app_mobile/screens/login/tripActivities/mainTripActivities.dart';
import 'package:tms_app_mobile/screens/template/screens/PurchaseButton.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';

class DocumentTrip extends StatefulWidget {
  late String idTrip;
  @override 
  _DocumentTripState createState() => _DocumentTripState();
  DocumentTrip(this.idTrip);
}

class _DocumentTripState  extends State<DocumentTrip> {
 

  TripModel tripmod = TripModel();
  
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
                           title: Text('MENUNGGU DOKUMEN DI VALIDASI ADMIN',
                           style: TextStyle(
                             fontWeight: FontWeight.bold
                           ),
                           ),
                         ),
                        ],
                      ),
                    ),
                    5.height,
                   Container(
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                         ListTile(
                           leading: Icon(Icons.info),
                           title: Text('Silahkan Tunggu, Validasi Dokumen oleh admin'),
                         ),  
                        ],
                      ),
                    ),
                    5.height,

                   FutureBuilder(
                    future: tripmod.getOneCurrentTrip('${widget.idTrip}'),
                    builder: (BuildContext context, AsyncSnapshot snapshot){

                      if(snapshot.data == null)
                      {
                        return CircularProgressIndicator(
                    backgroundColor: Color(0xFFACB5FD),
                    color: Color(0xFFf3f5f9),
                  );
                      } else {
                        return Container(
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        ListTile(
                           title: Text('DETAIL TRIP', style: TextStyle(fontWeight: FontWeight.bold,)),
                         ),
                         ListTile(
                            leading: Icon(Icons.tag),
                           title: Text('ID Trip : ${snapshot.data['data']['id']}'),
                         ),
                          ListTile(
                            leading: Icon(Icons.wheelchair_pickup),
                            title: Text('Transport No : ${snapshot.data['data']['transport_order_no']}'),
                         ),
                        
                         ListTile(
                            leading: Icon(Icons.streetview),
                           title: Text('Waybill No : ${snapshot.data['data']['waybill_no']}'),
                         ),
                         ListTile(
                           leading: Icon(Icons.add),
                           title: Text('BL No : ${snapshot.data['data']['bl_no']}'),
                         ),
                         Divider(),
                         ListTile(
                          leading: Icon(Icons.people),
                          title: Text('${snapshot.data['data']['project']['name']}'),
                         ),
                         ListTile(
                          leading: Icon(Icons.arrow_forward),
                          title: Text('${snapshot.data['data']['trip_detail_departure']['location']['name']}'),
                         ),
                         ListTile(
                          leading: Icon(Icons.pin_drop),
                          title: Text('${snapshot.data['data']['trip_detail_arrival']['location']['name']}'),
                         ),
                         Divider(),
                          ListTile(
                          leading: Icon(Icons.note),
                          title: Text('${snapshot.data['data']['remarks']}'),
                         ),


                        ],
                      ),
                    );
                      }


                  }),
                  
                     10.height,
                      quizButton(
                        textContent: 'Check Validasi Dokumen',
                        onPressed: () {
                        buatLoadingLogin(context);
                         tripmod.getOneCurrentTrip('${widget.idTrip}').then((value) => {
                           print(value['data']['status']),
                           if(value['data']['status'] == '08')
                           {
                             Navigator.pop(context),
                             Navigator.pushAndRemoveUntil<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => MainTripActivities('${widget.idTrip}'),
                            ),
                            (route) => false,),
                           } else {
                             Navigator.pop(context),
                             showDialog(
                              context: context,
                              builder: (BuildContext context) => new AlertDialog(
                              title: new Text('Peringatan'),
                              content: new Text('Dokumen Belum di validasi oleh admin, mohon tunggu !'),
                              actions: <Widget>[
                              new IconButton(
                              icon: new Icon(Icons.close),
                              onPressed: () {
                              Navigator.pop(context);
                              })
                              ],
                              )),

                           }


                         });
                        })
                
                ],
              ),
            ).paddingAll(16),
          ],
      
    );
  }

  
  buatLoadingLogin(BuildContext context) {
    return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightGreen,
                    color: Colors.lightBlue,
                  ),
                );
              });
  }

}
