import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/models/Trip_model.dart';
import 'package:tms_app_mobile/screens/login/tripActivities/CheckScan/CheckOut.dart';
import 'package:tms_app_mobile/screens/login/tripActivities/popUpGetJob.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizWidget.dart';



class ConfirmTripStep extends StatefulWidget {
  late String idTrip;
  @override 
  _ConfirmTripStepState createState() => _ConfirmTripStepState();
  ConfirmTripStep(this.idTrip);

}



class _ConfirmTripStepState extends State<ConfirmTripStep>{


  TripModel tripmod = TripModel();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Di Confirm Trip (ID) : ${widget.idTrip}');
  }
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
                           leading: Icon(Icons.star),
                           title: Text('trip.confirm_trip.title'.tr(),
                           style: TextStyle(
                             fontWeight: FontWeight.bold
                           ),
                           ),
                         ),
                        
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                   
                  10.height,
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
                          leading: Icon(Icons.flight_takeoff),
                          title: Text('${snapshot.data['data']['trip_detail_departure']['location']['name']}'),
                         ),
                         ListTile(
                          leading: Icon(Icons.flight_land),
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
                  16.height,
                  quizButton(
                        textContent: 'Scan Check Out',
                        onPressed: () {
                         Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => CheckOut('${widget.idTrip}'),
                                ),
                                (route) => false,);
                        })
                 
                ],
              ),
            ).paddingAll(16),
          ],
      
    );
  }
}
