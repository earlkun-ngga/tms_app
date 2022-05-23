import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/models/Trip_model.dart';
import 'package:tms_app_mobile/screens/login/dashboard/dashboard.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizWidget.dart';



class FinishTripStep extends StatefulWidget{

  String idTrip;
  FinishTripStep(this.idTrip);

  @override
  State<FinishTripStep> createState() => _FinishTripStepState();
}

class _FinishTripStepState extends State<FinishTripStep> {
  TripModel tripmod = TripModel();
  bool boolDetail = false;
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
                           title: Text('TRIP ANDA SUDAH SELESAI',
                           style: TextStyle(
                             fontWeight: FontWeight.bold
                           ),
                           ),
                         ),
                        
                        ],
                      ),
                    ),
                  
                  16.height,
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
                      
                      SizedBox(height: 30.0,),
                      Center(
                      
                      child:  Container(
                      decoration: boxDecorationDefault(shape: BoxShape.circle),
                      child: Image.asset('assets/success/success.png'),
                      height: 150.0,
                      ),),
                      SizedBox(height: 10.0,),
                      Divider(),
                       ListTile(
                           title: Text('DETAIL TRIP', style: TextStyle(fontWeight: FontWeight.bold,)),
                           trailing: InkWell(
                             child: (this.boolDetail == false) ? Icon(Icons.arrow_downward) : Icon(Icons.arrow_upward),
                             onTap: () {
                              if(this.boolDetail == true)
                              {
                                setState(() {
                                  this.boolDetail = false;
                                });
                              } else {
                                setState(() {
                                  this.boolDetail = true;
                                });
                              }
                             },

                           ),
                         ),
                         ListTile(
                            leading: Icon(Icons.tag),
                           title: Text('ID Trip : ${snapshot.data['data']['id']}'),
                         ),
                        
                        (this.boolDetail == true) ?
                        Column(
                          children: [
                             
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
                        ) : Container(),

                        
                        ],
                      ),
                    );
                      }


                  }),
                    SizedBox(height: 10.0,),
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
      
    );
  }
}
