import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:tms_app_mobile/models/Car_model.dart';
import 'package:tms_app_mobile/models/Service_model.dart';
import 'package:tms_app_mobile/models/SessionUser_model.dart';
import 'package:tms_app_mobile/models/Trip_model.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';



class DetailHistoryTrip extends StatefulWidget {

  String idTrip;
  @override 
  _DetailHistoryTripState createState() => _DetailHistoryTripState();
  DetailHistoryTrip(this.idTrip);
  
}

class _DetailHistoryTripState extends State<DetailHistoryTrip> {

  SessionUser sesuser = SessionUser();
  CarModel carmod = CarModel();
  Service_model servmod = Service_model();
  TripModel tripmod = TripModel();
  var dataCar;

  Future getDataCar() async  {
    return this.dataCar;
  }

  @override
  void initState() {
    // TODO: implement initState
    sesuser.getBarcodeValueDataCar().then((value) => {
      print(value),
      carmod.getInfoCarByQrCode(value.toString().substring(4)).then((value2) => {
        print(value2),
        setState(() {
            this.dataCar = value2;
        }),
      })
    });
  }


  Widget build(BuildContext context) {
    SessionUser sesuser = SessionUser();
    return Scaffold(
       backgroundColor: quiz_app_background,
       appBar: AppBar(
        title: Text(
          'Informasi Detail History Trip',
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
      body: Center(
      child: FutureBuilder(
      future: tripmod.getOneTripById('${widget.idTrip}'),   
      builder: (BuildContext context, AsyncSnapshot snapshot)
       {
         if(snapshot.data == null)
         {
            return CircularProgressIndicator();
         } else {
           print(snapshot.data);
           return ListView(
             children: [
               
               Column(
                    children: [
                    Container(
                    margin: const EdgeInsets.only(left:20, right: 20),
                    padding: const EdgeInsets.only(bottom: 15.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: boxDecoration(radius: 16, showShadow: true, bgColor: quiz_white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text('INFORMASI TRIP',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: Text('DI BUAT PADA : ${snapshot.data['data']['created_at']}'),
                        ),
                        ListTile(
                          leading: Icon(Icons.tag),
                          title: Text('ID TRIP : ${snapshot.data['data']['id']}'),
                        ),
                        ListTile(
                          leading: Icon(Icons.tag),
                          title: Text('WAYBILL NO : ${snapshot.data['data']['waybill_no']}'),
                        ),
                        ListTile(
                          leading: Icon(Icons.tag),
                          title: Text('BL NO : ${snapshot.data['data']['bl_no']}'),
                        ),
                        ListTile(
                          leading: Icon(Icons.tag),
                          title: Text('TRANSPORT NO : ${snapshot.data['data']['transport_order_no']}'),
                        ),
                        // Center(
                          
                        // child:

                        // (snapshot.data['data']['status'] == '01') ?
                        // Chip(
                        //       label: 
                        //       Text('REQUEST', 
                        //       style: TextStyle(color: Colors.white,
                        //       fontSize: 15,
                        //       fontWeight: FontWeight.bold
                        //                   ),),
                        //         backgroundColor: Colors.purpleAccent,
                        //       ) : (snapshot.data['data']['status'] == '02') ? 
                        // Chip(
                        //       label: 
                        //       Text('PROSES', 
                        //       style: TextStyle(color: Colors.white,
                        //       fontSize: 15,
                        //       fontWeight: FontWeight.bold
                        //                   ),),
                        //         backgroundColor: Colors.blueAccent,
                        //       ) : 
                        //  Chip(
                        //       label: 
                        //       Text('SELESAI (${snapshot.data['data']['finish_date']})', 
                        //       style: TextStyle(color: Colors.white,
                        //       fontSize: 15,
                        //       fontWeight: FontWeight.bold
                        //                   ),),
                        //         backgroundColor: Colors.greenAccent,
                        //       )
                        
                        
                        // )
                       
                      ],
                    ),
                  ),
          
                   ],
                  ),

                  SizedBox(height: 50.0,),
                  
                  // (snapshot.data['data']['manufacture_type'] == '01') ? 
                  
                  // FutureBuilder(
                  //   future: carmod.getInfoCarById('${snapshot.data['data']['car_id']}'),
                  //   builder: (BuildContext context, AsyncSnapshot snapshot)
                  // {

                  //   if(snapshot.data == null)
                  //   {
                  //     return Row(
                  //       mainAxisAlignment: MainAxisAlignment.center , crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         CircularProgressIndicator(),
                  //       ],
                  //     );
                  //   } else {

                  //     return DetailMobil('${snapshot.data['data']['plate_no']}', '${snapshot.data['data']['car_model']?['model'] ?? ''}', '${snapshot.data['data']['car_model']?['car_spec'][['tire']] ?? ''}');

                  //   }

                  // })
                  //  : 
                  // FutureBuilder(
                  //   future: carmod.getInfoTrailerById('${snapshot.data['data']['chasis_id']}'),
                  //   builder: (BuildContext context, AsyncSnapshot snapshot)
                  // {

                  //   if(snapshot.data == null)
                  //   {
                  //     return Row(
                  //       mainAxisAlignment: MainAxisAlignment.center , crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         CircularProgressIndicator(),
                  //       ],
                  //     );
                  //   } else {

                  //     return DetailTrailer('${snapshot.data['data']['uji_no']}', '${snapshot.data['data']['chasis_model']?['chasis_type_id'] ?? ''}');

                  //   }

                  // })




                  ]
                  );
         }
       }
       
       )
     ), );

  }

}

class DetailMobil extends StatelessWidget{

  String plateNo;
  String modelMobil;
  String jumlahTire;
  DetailMobil(this.plateNo, this.modelMobil, this.jumlahTire);

  Widget build(BuildContext context)
  {
    return Column(
                    children: [
                    Container(
                    margin: const EdgeInsets.only(left:20, right: 20),
                    padding: const EdgeInsets.only(bottom: 15.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: boxDecoration(radius: 16, showShadow: true, bgColor: quiz_white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text('INFORMASI KENDARAAN',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.tag),
                          title: Text('${this.plateNo}'),
                        ),
                         ListTile(
                          leading: Icon(Icons.straighten),
                          title: Text('Model : ${this.modelMobil}')
                        ),
                        //  ListTile(
                        //   leading: Icon(Icons.circle),
                        //   title: Text('Jumlah Ban : ${this.jumlahTire}')
                        // ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
          
                   ],
                  );
  }


}



class DetailTrailer extends StatelessWidget{

  String ujinoTrailer;
  String modelMobil;
  DetailTrailer(this.ujinoTrailer, this.modelMobil);

  Widget build(BuildContext context)
  {
    return Column(
                    children: [
                    Container(
                    margin: const EdgeInsets.only(left:20, right: 20),
                    padding: const EdgeInsets.only(bottom: 15.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: boxDecoration(radius: 16, showShadow: true, bgColor: quiz_white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text('INFORMASI KENDARAAN',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.tag),
                          title: Text('${this.ujinoTrailer}'),
                        ),
                         ListTile(
                          leading: Icon(Icons.straighten),
                          title: Text('Model : ${this.modelMobil}')
                        ),
                        //  ListTile(
                        //   leading: Icon(Icons.circle),
                        //   title: Text('Jumlah Ban : ${this.jumlahTire}')
                        // ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
          
                   ],
                  );
  }


}