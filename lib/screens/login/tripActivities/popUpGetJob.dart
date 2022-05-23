

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:skeletons/skeletons.dart';
import 'package:tms_app_mobile/models/Location_model.dart';
import 'package:tms_app_mobile/models/SessionUser_model.dart';
import 'package:tms_app_mobile/models/Trip_model.dart';
import 'package:tms_app_mobile/screens/login/dashboard/dashboard.dart';
import 'package:tms_app_mobile/screens/login/tripActivities/mainTripActivities.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizConstant.dart';



class PopUpGetJob extends StatefulWidget {

  late String tripId;
  late String idDriver;

  PopUpGetJob(this.tripId, this.idDriver);
  @override
  _PopUpGetJobState createState() => _PopUpGetJobState();

}


class _PopUpGetJobState extends State<PopUpGetJob> {

  late String dataCustomer;

  Future<void> popUpNotif() async {

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
                        FlutterLocalNotificationsPlugin();
                        const AndroidNotificationDetails androidPlatformChannelSpecifics =
                              AndroidNotificationDetails('your channel id', 'your channel name',
                                  channelDescription: 'your channel description',
                                  importance: Importance.max,
                                  priority: Priority.high,
                                  ticker: 'ticker');
              
              
              
                          const NotificationDetails platformChannelSpecifics =
                              NotificationDetails(android: androidPlatformChannelSpecifics);
                          await flutterLocalNotificationsPlugin.show(
                              0, 'Ada Trip !!', 'Silahkan ambil trip / job nya !!!', platformChannelSpecifics,
                              payload: 'item x');
  }


  TripModel trip = TripModel();
  LocationModel loctmod = LocationModel();
  SessionUser sesuser = SessionUser();


  @override
    initState(){
      print('${widget.tripId}');
      trip.getOneCurrentTrip('${widget.tripId}').then((value) => {
        print(value),
      });

      trip.getStreamTripByIdDriverOne('${widget.idDriver}').then((value) => {
        print('Data Trip Stream : ${value}'),
        setState((){
          // this.dataCustomer = value['data']['trip_last_pending']['name'];
        })

      });


    }


  @override 
  Widget build(BuildContext context)
  {
   return WillPopScope(
    onWillPop: () async => false,
    child: Scaffold(
      backgroundColor: quiz_app_background,
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    Container(
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                         ListTile(
                           title: Center(child: Text('ANDA MENDAPATKAN ORDER',
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 20.0
                           ),
                           ),)
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
                         ListTile(
                           title: Text('popupjob.anda_mendapatkan_order'.tr(),
                           style: TextStyle(fontWeight: FontWeight.bold),
                           ),
                         ),
                        Divider(),
                        FutureBuilder(
                          future: trip.getOneCurrentTrip('${widget.tripId}'),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if(snapshot.data == null) {
                              return Column(children: [
                                           ListTile(
                                             title: SkeletonLine(
                                                    style: SkeletonLineStyle(
                                                    height: 16,
                                                    width: 220.0,
                                                    borderRadius: BorderRadius.circular(4)),
                                              ) ,
                                           ),
                                           
                                           ListTile(
                                             title: SkeletonLine(
                                                    style: SkeletonLineStyle(
                                                    height: 16,
                                                    width: 220.0,
                                                    borderRadius: BorderRadius.circular(4)),
                                              ) ,
                                           ),
                                           
                                           ListTile(
                                             title: SkeletonLine(
                                                    style: SkeletonLineStyle(
                                                    height: 16,
                                                    width: 220.0,
                                                    borderRadius: BorderRadius.circular(4)),
                                              ) ,
                                           ),
                                           ListTile(
                                             title: SkeletonLine(
                                                    style: SkeletonLineStyle(
                                                    height: 16,
                                                    width: 220.0,
                                                    borderRadius: BorderRadius.circular(4)),
                                              ) ,
                                           ),
                              ],);
                            } else {
                        return Column(
                        children: [
                        ListTile(
                           leading: Icon(Icons.code),
                           title: Text('ID Trip : ${widget.tripId}'),
                         ),
                         ListTile(
                           leading: Icon(Icons.calendar_today),
                           title: Text('popupjob.tanggal'.tr(args: ['${snapshot.data['data']['created_at'].toString()}'])),
                         ),
                         ListTile(
                           leading: Icon(Icons.score),
                           title: Text('Waybill No :${snapshot.data['data']['waybill_no'].toString()}'),
                         ),

                          FutureBuilder(
                          future: trip.getStreamTripByIdDriverOne('${widget.idDriver}'),
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            if(snapshot.data == null)
                            {
                              return  ListTile(
                                             title: SkeletonLine(
                                                    style: SkeletonLineStyle(
                                                    height: 16,
                                                    width: 220.0,
                                                    borderRadius: BorderRadius.circular(4)),
                                              ) ,
                                           );
                            } else {
                              return  Column(
                            children: [
                            ListTile(
                              leading: Icon(Icons.people),
                              title: Text('Customer : ${snapshot.data['data']['trip_last_pending']['project']['name']}'),
                            ),
                             ListTile(
                              leading: Icon(Icons.arrow_forward),
                             
                              title: Text('popupjob.berangkat'.tr(args: ['${snapshot.data['data']['trip_last_pending']['trip_detail_departure']['location']['name']}'])),
                            ),
                             ListTile(
                              leading: Icon(Icons.pin_drop),
                              title: Text('popupjob.tiba'.tr(args: ['${snapshot.data['data']['trip_last_pending']['trip_detail_arrival']['location']['name']}'])),
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(Icons.note),
                              title: Text('popupjob.note'.tr(args: ['${snapshot.data['data']['trip_last_pending']['remarks']}'])),
                            ),
                       
                              ],);
                            }
                        }),
                         
                     
                                ],
                              );
                            }
                        })
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0,),
                  Row(
                    children: [
                    Expanded(
                      flex: 5,
                      child: quizButtonAccept(textContent: 'Confirm', onpressed: (){
                        buatLoadingLogin(context);
                        trip.updateStatusTripAccept('${widget.tripId}');
                        sesuser.setIdTrip('${widget.tripId}');
                        Navigator.of(context).pop();
                        Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => MainTripActivities('${widget.tripId}'),
                                ),
                                (route) => false,);
                      },)),
                    Expanded(
                      flex: 1,
                      child: Container()
                      ),
                    Expanded(
                      flex: 5,
                      child: quizButtonReject(textContent: 'Reject', idTrip: '${widget.tripId}',)
                    ),
                  ],)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
   
   
   
   
   

  }
}



class quizButtonAccept extends StatefulWidget {
  var textContent;

  //   var icon;
  VoidCallback onpressed;
  quizButtonAccept({
    required this.textContent,
    required this.onpressed
    //   @required this.icon,
  });

  @override
  _quizButtonAcceptState createState() => _quizButtonAcceptState();
}

// ignore: camel_case_types
class _quizButtonAcceptState extends State<quizButtonAccept> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onpressed,
      child: Container(
          decoration: boxDecoration(bgColor: Colors.greenAccent, radius: 16),
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                child: text(widget.textContent, textColor: t8_white, fontFamily: fontMedium, textAllCaps: false),
              ),
              
              
            ],
          )),
    );
  }
}




class quizButtonReject extends StatefulWidget {
  var textContent;
  String idTrip;

  //   var icon;
  

  quizButtonReject({
    required this.textContent,
    required this.idTrip
    
  
    //   @required this.icon,
  });

  @override
  _quizButtonRejectState createState() => _quizButtonRejectState();
}

// ignore: camel_case_types
class _quizButtonRejectState extends State<quizButtonReject> {
    TripModel trip = TripModel();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
                         buatLoadingLogin(context);
                        trip.updateStatusTripReject('${widget.idTrip}');
                              Navigator.of(context).pop();
                              Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => Dashboard(),
                                ),
                                (route) => false,);
      },
      child: Container(
          decoration: boxDecoration(bgColor: Colors.redAccent, radius: 16),
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                child: text(widget.textContent, textColor: t8_white, fontFamily: fontMedium, textAllCaps: false),
              ),
              
              
            ],
          )),
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
