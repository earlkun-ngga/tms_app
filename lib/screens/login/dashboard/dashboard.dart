import 'dart:async';
import 'package:easy_localization/src/public_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/models/Car_model.dart';
import 'package:tms_app_mobile/models/Geolocation_model.dart';
import 'package:tms_app_mobile/models/Trip_model.dart';
import 'package:tms_app_mobile/models/Version_model.dart';
import 'package:tms_app_mobile/models/Waktu_model.dart';
import 'package:tms_app_mobile/screens/login/dashboard/detailCarAbsent.dart';
import 'package:tms_app_mobile/screens/login/maintenanceCar/optionMaintenance.dart';
import 'package:tms_app_mobile/screens/login/tripActivities/mainTripActivities.dart';
import 'package:tms_app_mobile/screens/login/tripActivities/popUpGetJob.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizConstant.dart';
import 'package:skeletons/skeletons.dart';
import 'package:timezone/data/latest.dart' as tz;


//REQ LOCAL
import 'package:tms_app_mobile/screens/login/historyTrip/historyTrip.dart';
import 'package:tms_app_mobile/screens/login/settings/settings.dart';
import 'package:tms_app_mobile/screens/login/scanAbsent/step1ScanAbsent.dart';
import 'package:tms_app_mobile/models/SessionUser_model.dart';
import 'package:tms_app_mobile/models/UserDriver_model.dart';
import 'package:tms_app_mobile/screens/unlogin/loginPage.dart';
import 'package:tms_app_mobile/screens/unlogin/updateDialog.dart';


class Dashboard extends StatefulWidget {

  Dashboard();
  @override 
  _DashboardState createState() => _DashboardState();
}


class _DashboardState extends State<Dashboard> {
  //flags
  String bot = '0';
  bool statusAbsen = false;

  //bahasa 1-indonesia, 2-english, 3-korean

  String bahasaValue = '';


  //INFORMATION USER (FOR DISPLAY)
  String usr = '';
  String pss = '';
 
  
  String driver_id = '';
  //
  var dataCarState;
  var vardata;


  //ABSENT INFORMATION
   String plateno = '';
   String idCar = '';
   String idTrailer = '';
   String timeAbsent = '';
   String tripId = '';
   String statusTrip = '3';

  //INSTANCE CLASS
  SessionUser sesusr = SessionUser();
  UserDriver usrdriver = UserDriver();
  WaktuModel waktu = WaktuModel();
  TripModel trip = TripModel();
  CarModel carmod = CarModel();
  GeolocationModel geomod = GeolocationModel();
  Version ver = Version();

  //INITIAL LOOP REQUEST TIMER
  late Timer _timerRequestJob;

  @override
  void dispose(){
    print('terdispose !!!');
    _timerRequestJob.cancel();
    super.dispose();
  }

  @override
  void initState() {

    sesusr.getLanguageCode().then((value) => {
      print('Nilai Bahasa : ${value}'),
      setState(() {
        this.bahasaValue = value;
      })
    });

    ver.getInfoLastVersion().then((value) => {
    if(ver.currentVersion.toString() == value['data']['value'].toString())
    {
      print('Data Version : ${value}'),
     
    } else {
      print(value),
       Timer(Duration(seconds: 2),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder:
      (context) => UpdatePage('${value['data']['value']}')  )))
    }
  }).catchError(
    (error) {
      showDialog(
                              context: context,
                              builder: (BuildContext context) => new AlertDialog(
                                                title: new Text('Gagal'),
                                                content: new Text('Koneksi Anda Bermasalah, tidak dapat terhubung ke Server'),
                                                actions: <Widget>[
                                                  new IconButton(
                                                      icon: new Icon(Icons.history),
                                                      onPressed: () {
                                                       Navigator.pushAndRemoveUntil<dynamic>(
                                                        context,
                                                        MaterialPageRoute<dynamic>(
                                                          builder: (BuildContext context) => Dashboard(),
                                                        ),
                                                        (route) => false,);
                                                      })
                                                ],
                                              ));
    } 
  );



    print('Status Absen State : ${this.statusTrip}');
    sesusr.getDriverID().then((value) => {
      print('[SP] dashboard.dart : Data ID Driver : ${value}'),
       usrdriver.getStatusAbsent('${value}').then((value1) => {
          if(value1['data']['status'] == null)
          {
            setState((){
              this.statusAbsen = false;
            }),
          } else {
              if(value1['data']['driver']['driverCarLastMatch']['car_id'] == null)
              {
              setState((){
                this.statusAbsen = false;
              }),
              }
            else {
            setState((){
              this.statusAbsen = true;
              this.timeAbsent = '${value1['data']['date']} ${value1['data']['time']}';
              this.idCar = '${value1['data']['driver']['driverCarLastMatch']['car_id']}';
            }),
            },
            carmod.getInfoCarById('${value1['data']['car_id'].toString()}').then((value2) => {
              if(value2['data']['chasis_id'] == null) 
              {
                 setState(() {
                this.idTrailer = '';
              }),
              print('[SP] dashboard.dart  : Data Chasis / Trailer : Kosong')
              } else {
              setState(() {
                this.idTrailer = '${value2['data']['chasis_id'].toString()}';
              }),
              print('[SP] dashboard.dart  : Data Sasis : ${this.idTrailer}')
              }
            })
          }
        }),
    //check apakah ada trip
    trip.getOneCurrentTripByIdDriver('${value}').then((value1) async => {
      print('[SP] dashboard.dart  : Data Trip By Id Driver di Dashboard : ${value1['data']['id']}'),

      if(value1['data']['id'] == null)
      {
        print('dashboard.dart  : Data Trip Kosong !!!'),
        setState(() {
          this.bot = '0';
        })
      } else {
        print('dashboard.dart  : Data Trip Ada !!!'),
        print('dashboard.dart  : Status Trip Code : ${value1['data']['status']}'),
        setState(() {
          this.statusTrip = value1['data']['status'];
        }),
        if(value1['data']['status'] != '01' && value1['data']['status'] != '08'  && value1['data']['status'] != '07')
        {
          _timerRequestJob.cancel(),
          setState((){
            this.tripId = '${value1['data']['id']}';
            this.bot = '1';
          })
        } else if(value1['data']['status'] == '01') {   
          Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                           MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => PopUpGetJob('${value1['data']['id']}', '${this.driver_id}'),
                              ),
                          (route) => false,),      
        }
        else if(value1['data']['status'] == '07'){
          print('dashboard.dart  : Masuk di data status = 07'),
           setState((){
            this.tripId = '${value1['data']['id']}';
            this.bot = '1';
          })
        }
        else if(value1['data']['status'] == '08'){
          print('dashboard.dart  : Masuk di data status = 08'),
           setState((){
            this.bot = '0';
          })
        }
        else {
          setState((){
            this.bot = '0';
          })
        }
      }
    }),
      setState(() {
        this.driver_id = value;
      }),
    });

    sesusr.getUsername().then((value) => {
      print('[SP] dashboard.dart  : Data Username di Dashboard : ${value}'),
      setState(() {
          this.usr = value;
           sesusr.getPassword().then((value1) => {
              print('[SP] dashboard.dart  :  Data Password di Dashboard : ${value1}'),
              setState(() {
                this.pss = value1;
                print('In User : ${this.usr}');
                print('In Pss : ${this.pss}');
                usrdriver.prosesLogin(this.usr, this.pss).then((value3) => {
                  print('Data Login : ${value3}'),
                  if(value3['code'] == 405)
                  {
                    sesusr.clearDataSF(),
                    Navigator.pushAndRemoveUntil<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => LoginPage(),
                    ),
                    (route) => false,),
                  }
                  else {
                    print('Berhasil Login !'),
                  }
                });
              }),
            });
      }),
    });
    _timerRequestJob = Timer.periodic(Duration(seconds: 1), (timer) {
      if(this.statusAbsen == false)
      {
        print('dashboard.dart  : Anda Belum absen');
        timer.cancel();
      } else {
        setState(() {
          this.statusTrip = '01';
        });
        print('dashboard.dart  : Anda Sudah Absen .. Scanning Job...');
        trip.getStreamTripByIdDriverOne('${this.driver_id}').then((value) => {
          print(value['data']['driver_id']),
          if(value['data']['driver_id'] == null)
          {
            print('dashboard.dart  : Data Order Empty'),
 
          } else {
            print('dashboard.dart  : Data Order Avaialable'),
            Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => PopUpGetJob('${value['data']['trip_last_pending']['id']}', '${this.driver_id}'),
                              ),
                (route) => false,)
          }
        });
      }
     });
     tz.initializeTimeZones();
  }



  @override 
  Widget build(BuildContext context) {

    //PILIHAN BAHASA
    if(this.bahasaValue == '1')
    {
      context.locale = Locale('id', 'ID');
    } else if(this.bahasaValue == '2')
    {
      context.locale = Locale('en', 'US');
    }


    return FutureBuilder(
      future: usrdriver.prosesLogin(this.usr, this.pss).catchError(
                  (error) {
                    showDialog(
                              context: context,
                              builder: (BuildContext context) => new AlertDialog(
                                                title: new Text('dashboard.fail_connect'.tr()),
                                                content: new Text('dashboard.fail_connect_message'.tr()),
                                                actions: <Widget>[
                                                  new IconButton(
                                                      icon: new Icon(Icons.history),
                                                      onPressed: () {
                                                       Navigator.pushAndRemoveUntil<dynamic>(
                                                        context,
                                                        MaterialPageRoute<dynamic>(
                                                          builder: (BuildContext context) => Dashboard(),
                                                        ),
                                                        (route) => false,);
                                                      })
                                                ],
                                              ));
                  } 
                ),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.data == null) {
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
                  Text('dashboard.pleasewait'.tr(), style: TextStyle(
                  color: Colors.grey
                ),),
                ],)
              ,),
            );
            
        } else {
        return RefreshIndicator(child: 
        DoubleBack(
          child: Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
          body:  SafeArea(
          child: ListView(
            
            children: <Widget>[
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start , crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  Container(
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(10), boxShadow: defaultBoxShadow()),
                      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start, 
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Row(
                        children: [
                       Expanded(
                         flex: 5,
                         child:Column(
                          mainAxisAlignment: MainAxisAlignment.start, 
                          crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                          Row(
                            
                            children: [
                         Container(
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (
                            this.statusTrip == '02' 
                            || 
                            this.statusTrip == '03'  
                            ||
                            this.statusTrip == '04'  
                            ||
                            this.statusTrip == '05'  
                            ||
                            this.statusTrip == '06'  
                            ||
                            this.statusTrip == '07'  
                            ) // VALIDASI APAKAH SUDAH ABSEN ATAU BELUM
                            ? 
                            Colors.blueAccent :
                            (this.statusTrip == '01') ?
                            Colors.lightGreen : Colors.redAccent),
                                          width: 25,
                                          height: 25,                  
                                        ),
                            Flexible(child: Container(
                              child: Container(
                                child: text(' ${snapshot.data['data']['driver']['name']}', fontFamily: fontBold, fontSize: 20.0),
                              ),
                            ))
                            ],),
                            text('#${snapshot.data['data']['driver']['id_number']}', textColor: quiz_textColorSecondary, isLongText: true, isCentered: true),
                        ],),),
                       Expanded(
                         flex: 5,
                         child:  Column(
                          mainAxisAlignment: MainAxisAlignment.end, 
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [ 
                            //{waktu.getTanggalFirstFormat()}
                              Chip(label: 
                              Text('${waktu.getTanggalFirstFormat()}', 
                              style: TextStyle(color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                              ),),
                    backgroundColor: Colors.blueAccent,
                  )],))
                      ],)],)),],),),
                Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(children: [
                    Image.asset(
                    'assets/menu_image/count_trip.jpg',
                    fit: BoxFit.fill,
                  ),

          Padding(
            padding: const EdgeInsets.only(top:120.0, left: 25.0),
            child: 
               
                  FutureBuilder(future: trip.getCountTripByIdDriverCurrentMonth('${this.driver_id}'),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(snapshot.data == null){
                      print('Data Count Trip : ${snapshot.data}');
                      return Text('....',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                      ),);
                    } else {
                      return Text('Total Trip : ${snapshot.data['data']} Trip',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                      ),  
                      );
                }},),),],),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                ),
                ), 
                    SizedBox(height: 10.0,),
                    Container(
                     margin: const EdgeInsets.only(left:20, right: 20),
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      child: Column(
                        children: <Widget>[
                          (this.statusAbsen == false) ?
                          InkWell(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
                                          width: 45,
                                          height: 45,
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.qr_code_2,
                                            color: quiz_white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text('dashboard.button_absent'.tr(),
                                        style: TextStyle(
                                          color: quiz_textColorPrimary,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold
                                        ),
                                        ),
                                      ],
                                    ),
                                            Icon(
                                              Icons.keyboard_arrow_right,
                                              color: quiz_icon_color,
                                            )
                                  ],
                                ),
                          ),
                      onTap: () {
                           Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => ScanAbsent('${snapshot.data['data']['driver']['id']}', '${snapshot.data['data']['user_id']}'),
                                ),
                                (route) => false,);
                                },
                          ) : InkWell(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start , crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                              FutureBuilder(
                                                future: carmod.getInfoCarById('${this.idCar}'),
                                                builder: (BuildContext context, AsyncSnapshot snapshot)
                                              {
                                                if(snapshot.data == null) {
                                                  return  SkeletonLine(
                                                    style: SkeletonLineStyle(
                                                    height: 16,
                                                    width: 220.0,
                                                    borderRadius: BorderRadius.circular(4)),
                                              );
                                                } else {
                                              return Column(
                                                
                                                mainAxisAlignment: MainAxisAlignment.start , crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                Text('Plat No : ${snapshot.data['data']['plate_no']}',
                                                  style: TextStyle(
                                                    color:  Colors.grey,
                                                    fontSize: 20.0
                                                  ),
                                                  ),
                                                SizedBox(height: 5,),
                                               Text('UJI No : ${snapshot.data['data']['chasis']?['uji_no'] ?? '[TIDAK ADA TRAILER]'}'.tr(),
                                                style: TextStyle(
                                                color:  Colors.grey,
                                                fontSize: 18.0
                                                ),)],);
                                                }
                                              }),
                                              SizedBox(height: 5,),
                                              Text('Absent : ${this.timeAbsent}',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0
                                              ),
                                              ),],
                                        ),
                                        )
                                      ],
                                    ),   
                                  ],
                                ),
                          ),
                          onTap: () {
                             Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => DetailCarAbsent('${snapshot.data['data']['driver']['id']}', '${snapshot.data['data']['user_id']}', '${this.idCar}'),
                                ),
                                (route) => false,);
                         
                          },
                          )], ),),
                  SizedBox(height: 10.0,),
                  (this.bot == '1') ? Container(
                     margin: const EdgeInsets.only(left:20, right: 20),
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.greenAccent),
                                          width: 45,
                                          height: 45,
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.run_circle,
                                            color: quiz_white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          'dashboard.onjob_button'.tr(),
                                          style: TextStyle(
                                          color: quiz_textColorPrimary,
                                          fontSize: 18.0
                                        ),
                                        ),
                                      ],
                                    ),
                                            Icon(
                                              Icons.keyboard_arrow_right,
                                              color: quiz_icon_color,
                                            )
                                  ],
                                ),
                          ),
                      onTap: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MainTripActivities('${this.tripId}')),);
                                },
                          ),], ),) : Container(),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Expanded(
                      child: Container(
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(left:20),
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            child:  cardMenuButton('dashboard.history_trip'.tr(), Icons.history, quiz_color_setting ),
                            onTap: () {
                            Navigator.push(
                            context,
                              MaterialPageRoute(builder: (context) => HistoryTrip(this.driver_id)),
                              );
                            },
                          ),
                          InkWell(
                            child: cardMenuButton('dashboard.settings'.tr(), Icons.settings, quiz_color_setting ),
                            onTap: () {
                              Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => Settings()),
                              );
                            },
                          ),
                        ],
                      ),
                    )),
                    VerticalDivider(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(color: quiz_white, borderRadius: BorderRadius.circular(8), boxShadow: defaultBoxShadow()),
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            child:  cardMenuButton('dashboard.maintenance'.tr(), Icons.car_repair, quiz_color_setting ),
                            onTap: () {
                              //  Navigator.push(
                              // context,
                              //   MaterialPageRoute(builder: (context) => ScanMaintenance('${snapshot.data['data']['driver']['name']}')),
                              //   );
                              Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => OptionMaintenance('${this.driver_id}', '${snapshot.data['data']['user_id']}')),
                                );
                            },
                          ),
                          InkWell(
                            child:  cardMenuButton('dashboard.logout'.tr(), Icons.logout, quiz_color_setting ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => new AlertDialog(
                                  title: new Text('Peringatan !'),
                                  content: new Text('Apakah Anda Ingin Logout ?'),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end , crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            icon: new Icon(Icons.check,
                                            color: Colors.greenAccent,
                                            ),
                                            onPressed: () async {
                                             sesusr.clearDataSF();
                                              Navigator.pushAndRemoveUntil<dynamic>(
                                                context,
                                                MaterialPageRoute<dynamic>(
                                                  builder: (BuildContext context) => LoginPage(),
                                                ),
                                                (route) => false,);
                                            }),
                                        IconButton(
                                            icon: new Icon(Icons.close,
                                            color: Colors.redAccent
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                      ],
                                    )
                                  ],
                                ));


                              
                              },
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),

               
                ],
              ),
            ),
          ],
        ),
      ),
      

      
    ),
        message: 'Tekan 2 kali untuk keluar !!!',
        ), onRefresh: ()async {
      
      Navigator.pushAndRemoveUntil<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => Dashboard(),
                    ),
                    (route) => false,);

    });
    
    
    
    }});
    
    
    
    }}


class cardMenuButton extends StatelessWidget
{
  var iconnya;
  Color colorIcon;
  String judul;
  cardMenuButton(this.judul, this.iconnya, this.colorIcon);
  @override
  Widget build(BuildContext context)
  {

    return Padding(
    padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: colorIcon),
              width: 45,
              height: 45,
              padding: EdgeInsets.all(4),
              child: Icon(
                iconnya,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Text('${this.judul}',
            ),
          ],
        ),
      ],
    ),
  );
  }

}





