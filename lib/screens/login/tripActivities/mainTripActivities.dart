import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/models/SessionUser_model.dart';
import 'package:tms_app_mobile/models/Trip_model.dart';
import 'package:tms_app_mobile/screens/login/dashboard/dashboard.dart';
import 'package:tms_app_mobile/screens/login/tripActivities/1_confirmTrip.dart';
import 'package:tms_app_mobile/screens/login/tripActivities/2_StartTrip.dart';
import 'package:tms_app_mobile/screens/login/tripActivities/3_EndTrip.dart';
import 'package:tms_app_mobile/screens/login/tripActivities/4_Document.dart';
import 'package:tms_app_mobile/screens/login/tripActivities/5_Finish.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';



class MainTripActivities extends StatefulWidget {
  
  String tripId;
  MainTripActivities(this.tripId);
  @override
  _MainTripActivitiesState createState() => _MainTripActivitiesState();
}

class _MainTripActivitiesState extends State<MainTripActivities> {

  
  int pointStep = 0;
  String textButton = '';
  SessionUser sesusr = SessionUser();
  TripModel tripmod = TripModel();
  
  @override 
  initState() {


   

    tripmod.getOneCurrentTrip('${widget.tripId}').then((value) => {
      print('${value['data']['id']}'),
      print('${value['data']['status']}'),
      print('mainTripActivities.dart : Data Trip -> ${value}'),
      if(value['data']['status'] == '02' || value['data']['status'] == '01' )
      {
        setState((){
          pointStep = 1;
          textButton = 'Start Trip';
        })
      } else if(value['data']['status'] == '05')
      {
        setState((){
          pointStep = 2;
          textButton = 'End Trip';
        })
      } else if(value['data']['status'] == '06')
      {
        setState((){
          pointStep = 3;
          textButton = 'Checking Document';
        })
      } else if(value['data']['status'] == '07')
      {
        setState((){
          pointStep = 4;
          textButton = 'Confirm Finish Job';
        })
      } 
      else if(value['data']['status'] == '08')
      {
          setState((){
          pointStep = 5;
          textButton = 'Finish Job';
        })
      }
    });
  }

  @override
  Widget build(BuildContext context) {
  changeStatusColor(quiz_app_background);
    return WillPopScope(
    onWillPop: () async => false,
    child: FutureBuilder(
      future: tripmod.getOneCurrentTrip('${widget.tripId}'),
      builder: (BuildContext context, AsyncSnapshot snapshot){

        if(snapshot.data == null)
        {
          return Scaffold(
              body: Center(
                child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  CircularProgressIndicator(
                    backgroundColor: Color(0xFFACB5FD),
                    color: Color(0xFFf3f5f9),
                  ),
                  SizedBox(height: 20,),
                  Text('Mohon Tunggu...', style: TextStyle(
                  color: Colors.grey
                ),),
                ],)
              ,),
            );
        } else {
          return Scaffold(
      backgroundColor: quiz_app_background,
      appBar: AppBar(
        title: Text(
          'TRIP',
          style: primaryTextStyle(size: 18, fontFamily: "Medium"),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: quiz_colorPrimary,
          size: 30,
        ).onTap(() {
          Navigator.of(context).pop();
                              Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => Dashboard(),
                                ),
                                (route) => false,);
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
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center , crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Column(
                          children: [
                            Icon(Icons.radio_button_on,color: Colors.greenAccent),
                            Text('Confirm', style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.greenAccent,
                              ),)
                          ],
                        ),
                        Container(width: 5.0,),
                        //STEP CHECK IN
                        Container(
                          color: (pointStep > 1) ? Colors.greenAccent : Colors.grey,
                          height: 5.0,
                          width: 25.0,
                          ),
                        Container(width: 5.0,),
                        Column(
                          children: [
                            Icon(
                              (pointStep > 1) ? Icons.radio_button_on : Icons.radio_button_off
                              ,color: (pointStep > 1) ? Colors.greenAccent : Colors.grey ),
                            Text('Start Trip', style: TextStyle(
                              fontSize: 10.0,
                              color: (pointStep > 1) ? Colors.greenAccent : Colors.grey,
                              ),)
                          ],
                        ),
                        Container(width: 5.0,),
                        //STEP CHECK IN
                        Container(
                          color: (pointStep > 2) ? Colors.greenAccent : Colors.grey,
                          height: 5.0,
                          width: 25.0,
                          ),
                        Container(width: 5.0,),
                        Column(
                          children: [
                            Icon( (pointStep > 2) ? Icons.radio_button_on : Icons.radio_button_off ,
                            color: (pointStep > 2) ? Colors.greenAccent : Colors.grey,),
                            Text('End Trip', style: TextStyle(
                              fontSize: 10.0,
                              color: (pointStep > 2) ? Colors.greenAccent : Colors.grey,))
                          ],
                        ),
                        Container(width: 5.0,),
                        //STEP DOCUMENT
                         Container(
                          color:(pointStep > 3) ? Colors.greenAccent : Colors.grey,
                          height: 5.0,
                          width: 25.0,
                          ),
                        Container(width: 5.0,),
                        Column(
                          children: [
                            Icon( (pointStep > 3) ? Icons.radio_button_on : Icons.radio_button_off ,
                            color: (pointStep > 3) ? Colors.greenAccent : Colors.grey,),
                            Text('Document', style: TextStyle(
                              fontSize: 10.0,
                              color: (pointStep > 3) ? Colors.greenAccent : Colors.grey,))
                          ],
                        ),
                        Container(width: 5.0,),
                        //STEP FINISH
                        Container(
                          color:(pointStep > 4) ? Colors.greenAccent : Colors.grey,
                          height: 5.0,
                          width: 25.0,
                          ),
                        Container(width: 5.0,),
                        Column(
                          children: [
                            Icon( (pointStep > 4) ? Icons.radio_button_on : Icons.radio_button_off ,
                            color: (pointStep > 4) ? Colors.greenAccent : Colors.grey,),
                            Text('Finish', style: TextStyle(
                              fontSize: 10.0,
                              color: (pointStep > 4
                              ) ? Colors.greenAccent : Colors.grey,))
                          ],
                        ),
                        Container(width: 5.0,),
                      ],
                    ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  if(this.pointStep == 1) // 02 API
                    ConfirmTripStep('${widget.tripId}'),
                  if(this.pointStep == 2) // 05 API
                    StartTripStep('${widget.tripId}'),
                  if(this.pointStep == 3) // 06 API
                    EndTripStep(),
                  if(this.pointStep == 4) // 07 API
                    DocumentTrip('${widget.tripId}'),
                  if(this.pointStep == 5) // 08 API
                    FinishTripStep('${widget.tripId}'),

                   
                  ],
                ),
              ),
            ),
          ),




          
        ],
      ),
    );
        }

      },
      
    )
  );
    
    
    
    
  }
}



