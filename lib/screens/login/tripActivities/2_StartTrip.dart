import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/models/Trip_model.dart';
import 'package:tms_app_mobile/screens/login/dashboard/dashboard.dart';
import 'package:tms_app_mobile/screens/login/tripActivities/CheckScan/CheckIn.dart';
import 'package:tms_app_mobile/screens/template/screens/PurchaseButton.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';

class StartTripStep extends StatefulWidget {

  String idTrip;
  @override
  _StartTripState createState() => _StartTripState();
  StartTripStep(this.idTrip);

}

class _StartTripState extends State<StartTripStep>{
  
  bool boolRute = true;
  bool boolDetail = false;
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
                           leading: Icon(Icons.edit_road),
                           title: Text('trip.start_trip.title'.tr(),
                           style: TextStyle(
                             fontWeight: FontWeight.bold
                           ),
                           ),
                         ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5,),
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
                        return Column(children: [

                          Container(
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        ListTile(
                           title: Text('trip.start_trip.detail_rute'.tr(), style: TextStyle(fontWeight: FontWeight.bold,)),
                           trailing: InkWell(child: 
                          (this.boolRute == true) ? Icon(Icons.arrow_upward) : Icon(Icons.arrow_downward),
                           onTap: (() {
                            if(this.boolRute)
                            {
                              setState(() {
                                this.boolRute = false;
                              });
                            } else {
                              setState(() {
                                this.boolRute = true;
                              });
                            }
                           }),
                           ),
                         ),
                        (this.boolRute == true) ?
                        Column(children: [
                         ListTile(
                          leading: Icon(Icons.flight_takeoff),
                          title: Text('${snapshot.data['data']['trip_detail_departure']['location']['name']}'),
                         ),
                          ListTile(
                          leading: Icon(Icons.circle, color: Colors.greenAccent,),
                          title: Text('IN'),
                          trailing: InkWell(child: Icon(Icons.done),)
                         ),
                          ListTile(
                          leading: Icon(Icons.circle, color: Colors.greenAccent,),
                          title: Text('OUT'),
                          trailing: InkWell(child: Icon(Icons.done),)
                         ),
                         ListTile(
                          leading: Icon(Icons.flight_land),
                          title: Text('${snapshot.data['data']['trip_detail_arrival']['location']['name']}'),trailing: InkWell(child: Icon(Icons.done),),
                         ),
                         ListTile(
                          leading: Icon(Icons.circle, color: Colors.greenAccent,),
                          title: Text('IN'),
                          trailing: InkWell(child: Icon(Icons.done),)
                         ),
                        //   ListTile(
                        //   leading: Icon(Icons.circle, color: Colors.grey,),
                        //   title: Text('OUT'),
                        //   trailing: InkWell(child: Icon(Icons.qr_code),)
                        //  ),
                         ListTile(
                          leading: Icon(Icons.circle, color: Colors.greenAccent,),
                          title: Text('OUT'),
                          trailing: InkWell(child: Icon(Icons.done),)
                         ),
                        ],) : Container(),
                        ],
                      ),
                    ),
                      SizedBox(height: 10.0,),
                      Container(
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        ListTile(
                           title: Text('DETAIL TRIP', style: TextStyle(fontWeight: FontWeight.bold,)),
                           trailing: InkWell(child: 
                          (this.boolDetail == true) ? Icon(Icons.arrow_upward) : Icon(Icons.arrow_downward),
                           onTap: (() {
                            if(this.boolDetail)
                            {
                              setState(() {
                                this.boolDetail = false;
                              });
                            } else {
                              setState(() {
                                this.boolDetail = true;
                              });
                            }
                           }),
                           ),
                         ),
                        (this.boolDetail == true) ?
                        Column(children: [
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
                          leading: Icon(Icons.note),
                          title: Text('${snapshot.data['data']['remarks']}'),
                         ),

                        ],) : Container(),

                        
                        ],
                      ),
                    ),

                        ],);
                      }


                  }),
                  Container(
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        
                         
                        
                       

                        ],
                      ),
                    ),
                     SizedBox(
                          height: 10.0,
                        ),
                          quizButton(
                        textContent: 'Scan Check In (Pulang)',
                        onPressed: () {
                         Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => CheckIn('${widget.idTrip}'),
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
