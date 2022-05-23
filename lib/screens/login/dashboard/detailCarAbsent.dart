import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:accordion/accordion.dart';
import 'package:tms_app_mobile/models/Car_model.dart';
import 'package:tms_app_mobile/models/SessionUser_model.dart';
import 'package:tms_app_mobile/models/Trip_model.dart';
import 'package:tms_app_mobile/screens/login/dashboard/dashboard.dart';
import 'package:tms_app_mobile/screens/login/scanAbsent/step1ScanAbsent.dart';
import 'package:tms_app_mobile/screens/login/scanChangeCar/step1ScanChangeCar.dart';
import 'package:tms_app_mobile/screens/login/scanChangeTrailer/step1ScanChangeTrailer.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizConstant.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizWidget.dart';




class DetailCarAbsent extends StatefulWidget {

  late String idDriver;
  late String userId;
  late String idCar;
  @override 
  _DetailCarAbsentState createState() => _DetailCarAbsentState();
  DetailCarAbsent(this.idDriver, this.userId, this.idCar);
  
}

class _DetailCarAbsentState extends State<DetailCarAbsent> {

  SessionUser sesuser = SessionUser();
  CarModel carmod = CarModel();
  TripModel tripmod = TripModel();
  var dataCar;

  var statusjob;

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


    tripmod.getOneCurrentTripByIdDriver('${widget.idDriver}').then((value) => {
      print('Data : ${value}'),
      print('Data Status : ${value['data']['status']}'),
      setState(() {
        this.statusjob = '${value['data']['status']}';
      })
    });


  }


  Widget build(BuildContext context) {
    SessionUser sesuser = SessionUser();
    return Scaffold(
       backgroundColor: quiz_app_background,
       appBar: AppBar(
        title: Text(
          'Informasi Detail Mobil dan Trailer',
          style: primaryTextStyle(size: 18, fontFamily: "Medium"),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: quiz_colorPrimary,
          size: 30,
        ).onTap(() {
          // Navigator.of(context).pop();
           Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>Dashboard(),
                                ),
                                (route) => false,);
        }),
        centerTitle: true,
        backgroundColor: quiz_app_background,
        elevation: 0.0,
      ),
      body: Center(
      child: FutureBuilder(
      future: carmod.getInfoCarById('${widget.idCar}'),   
      builder: (BuildContext context, AsyncSnapshot snapshot)
       {
         if(snapshot.data == null)
         {
            return CircularProgressIndicator();
         } else {
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
                        title: Text(
                                  'INFORMASI MOBIL', style: TextStyle(
                                  color: quiz_textColorSecondary, fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                Text(
                                  'Plat Nomor Mobil : ${snapshot.data['data']['plate_no']}', style: TextStyle(
                                  color: quiz_textColorSecondary, fontSize: 20.0
                                ),),
                                 Divider(),
                                Text(
                                  'Model : ${snapshot.data['data']['car_model']?['model'] ?? ''}', style: TextStyle(
                                  color: quiz_textColorSecondary, fontSize: 20.0
                                ),),
                                  Divider(),
                                Text(
                                  'Vendor : ${snapshot.data['data']['vendor']?['name'] ?? ''}', style: TextStyle(
                                  color: quiz_textColorSecondary, fontSize: 20.0
                                ),),                    
                                ],
                              ),
                            ],
                          ),
                        ),
                         Container(
                                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                                          child:   Row(
                                          children: [
                                            Expanded(
                                            child: 
                                            Container(
                                                  child: qb2(
                                                      textContent: 'GANTI MOBIL',
                                                      onPressed: () async {
                                                      Navigator.push(
                                                            context,
                                                              MaterialPageRoute(builder: (context) => ScanChangeCar('${widget.idDriver}', '${widget.userId}')),
                                                              );
                                                      print('GANTI MOBIL !');
                      })),
                      ),
                      VerticalDivider(),
                      ],)),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.info),
                        title: Text(
                                  'INFORMASI TRAILER', style: TextStyle(
                                  color: quiz_textColorSecondary, fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                      ),
                       Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                Text(
                                  'Uji No : ${snapshot.data['data']['chasis']?['uji_no'] ?? '(Tidak Ada)'}', style: TextStyle(
                                  color: quiz_textColorSecondary, fontSize: 20.0
                                ),),
                                 Divider(),
                                Text(
                                  'Nomor Trailer : ${snapshot.data['data']['chasis']?['trailer_no'] ?? '(Tidak Ada)'}', style: TextStyle(
                                  color: quiz_textColorSecondary, fontSize: 20.0
                                ),),
                                  Divider(),                     
                                ],
                              ),
                            ],
                          ),
                        ),
                         Container(
                                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                                          child:   Row(
                                          children: [
                                            Expanded(
                                            child: 
                                            Container(
                                                  child: qb2(
                                                      textContent: 'GANTI TRAILER',
                                                      onPressed: () async {
                                                      Navigator.push(
                                                            context,
                                                              MaterialPageRoute(builder: (context) => ScanChangeTrailer('${widget.idDriver}', '${widget.userId}',
                                                              '${widget.idCar}'
                                                              
                                                              )),
                                                              );
                                                      print('GANTI TRAILER');
                                                })),
                                            ),
                                        ],
                                      )
                                      ),


                      SizedBox(height: 30.0,),
                      Divider(),
                      SizedBox(height: 30.0,),
                      (this.statusjob == '07') ? Container(
                                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                                          child:   Row(
                                          children: [
                                            Expanded(
                                            child: 
                                            Container(
                                                  child: qb2local(
                                                      textContent: 'BUAT JOB BARU',
                                                      warnaBg: Colors.greenAccent,
                                                      onPressed: () async {
                                                      Navigator.push(
                                                            context,
                                                              MaterialPageRoute(builder: (context) => 
                                                              ScanAbsent('${widget.idDriver}', '${widget.userId}'
                                                              )),
                                                              );
                                                      // print('GANTI TRAILER');
                                                })),
                                            ),
                                        ],
                                      )
                      ) : Column(
                        children: [
                          Container(
                                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                                          child:   Row(
                                          children: [
                                            Expanded(
                                            child: 
                                            Container(
                                                  child: qb2local(
                                                      textContent: 'BUAT JOB BARU',
                                                      warnaBg: Colors.grey,
                                                      onPressed: () async {
                                                      // Navigator.push(
                                                      //       context,
                                                      //         MaterialPageRoute(builder: (context) => ScanChangeTrailer('${widget.idDriver}', '${widget.userId}',
                                                      //         '${widget.idCar}'
                                                      //         )),
                                                      //         );
                                                      print('GA BISA !');
                                                })),
                                            ),
                                        ],
                                      )
                      ),
                      Padding(padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 20.0),
                      child: 
                      Text('Buat Trip Baru, Hanya bisa di lakukan, ketika Status Trip sudah di penyerahan dokumen',
                      style: TextStyle(color: Colors.grey),
                      ),)
                        ],
                      )


                      ],
                    ),
                  ),
          
          ],
                  )
                  ]
                  );
         }
       }
       
       )
     ), );

  }

}





class qb2local extends StatefulWidget {
  var textContent;
  Color warnaBg;

  //   var icon;
  VoidCallback onPressed;

  qb2local({
    required this.textContent,
    required this.onPressed,
    required this.warnaBg,

    //   @required this.icon,
  });

  @override
  qb2localstate createState() => qb2localstate();
}

// ignore: camel_case_types
class qb2localstate extends State<qb2local> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
          decoration: boxDecoration(bgColor: widget.warnaBg, radius: 16),
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




