import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tms_app_mobile/models/Trip_model.dart';
import 'package:tms_app_mobile/models/Version_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

//REF LOCAL
import 'package:tms_app_mobile/screens/login/dashboard/dashboard.dart';
import 'package:tms_app_mobile/models/SessionUser_model.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/screens/unlogin/updateDialog.dart';
import 'screens/unlogin/loginPage.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_background_service/flutter_background_service.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  //DISABLE LANDSCAPE MODE
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
         );
  const MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  final LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(
    defaultActionName: 'Open notification',
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    macOS: initializationSettingsMacOS,
    linux: initializationSettingsLinux,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    
    EasyLocalization(child: MyApp(), 
    supportedLocales: [
      Locale('en', 'US'),
      Locale('id', 'ID'),
    ], 
    path: 'assets/translations'
    ),
  );
}

  Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will executed when app is in foreground or background in separated isolate
      onStart: onStart,
      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,
      // this will executed when app is in foreground in separated isolate
      onForeground: () { print ('ios ok !!');},
      // you have to enable background fetch capability on xcode project
      onBackground:() { print ('ios ok !!');},
    ),
  );
}

void onIosBackground() {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');
}
void onStart() {
  WidgetsFlutterBinding.ensureInitialized();
  TripModel tripmod = TripModel();
  final service = FlutterBackgroundService();
  // bring to foreground
  service.setForegroundMode(true);
  Timer.periodic(const Duration(seconds: 5), (timer) async {
    service.setNotificationInfo(
      title: "K-TMS APP Background Service",
      content: "Berjalan di Latar belakang (Tap untuk membuka aplikasi)",
    );
    SharedPreferences prefiddriver = await SharedPreferences.getInstance();
    if(prefiddriver.getString('id_driver') == null)
    {
      print('BELUM LOGIN !!');
    } else {
      
      await tripmod.getStreamTripByIdDriverOne(prefiddriver.getString('id_driver').toString()).then((value) => {
        if(value['data']['driver_id'] == null){
         
        } else {
            popUpNotif(), 
            print('main.dart : Pop Up Dispatching '),
            // [WAJIB] print('POP UP MUNCUL !!!'),
            // print('NGEDELAY !!!!'),   
        }
      });
    }
    prefiddriver.reload();
  });
}



Future<void> popUpNotif() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
                        const AndroidNotificationDetails androidPlatformChannelSpecifics =
                          AndroidNotificationDetails('your channel id', 'your channel name',
                          channelDescription: 'your channel description',
                          importance: Importance.max,
                          priority: Priority.high,
                          ticker: 'ticker');
    InitializationSettings initializationSettings = InitializationSettings();
                    const NotificationDetails platformChannelSpecifics =
                          NotificationDetails(
                            android: androidPlatformChannelSpecifics);
                          await flutterLocalNotificationsPlugin.show(
                              0, 'Ada Trip !!', 'Silahkan ambil trip / job nya !!!', 
                              platformChannelSpecifics,
                              payload: ('item x'));
  }

  
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'K-TMS APP',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QuizSplashScreen()
    );
  }
}


class QuizSplashScreen extends StatefulWidget {
  @override
  _QuizSplashScreenState createState() => _QuizSplashScreenState();
}

class _QuizSplashScreenState extends State<QuizSplashScreen> {
  
  String valsp = '';
  bool isNewerVer = true;
  SessionUser sesusr = SessionUser();
  Version ver = Version();

  @override
  void initState() {
  super.initState();


  ver.getInfoLastVersion().then((value) => {
    if(ver.currentVersion.toString() == value['data']['value'].toString())
    {
      print(value),
       Timer(Duration(seconds: 2),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder:
      (context) => (this.valsp == '') ? LoginPage() : Dashboard()   )))
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
                                        icon: new Icon(Icons.close),
                                        onPressed: () {
                                          exit(0);
                                        })
                                  ],
                                ));
    } 
  );
  sesusr.getUsername().then((value) => {
        // print('[SP] di Main Dart : ${value}'),
        setState(() {
          this.valsp = value;
        })
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(shape: BoxShape.circle,),
                    child:  
                    Image.asset('assets/menu_icon/truck_2.png',
                                height: MediaQuery.of(context).size.width * 0.3, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,)
                  ),
                SizedBox(width: 10.0,),
                Text('KTMS-APP', style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0
                ),),
              ],
            ),
            SizedBox(height: 10.0,),
            Text('FOR DRIVER USAGE', style: TextStyle(
              color: quiz_textColorSecondary,
              fontSize: 12.0
            ),),
            SizedBox(height: 20.0,),
            SizedBox(height: 20.0,),
            SizedBox(height: 20.0,),
            SizedBox(height: 100.0,),
            SizedBox(height: 20.0,),
             Text('Checking Version', style: TextStyle(
              color: Colors.grey
            ),),
            SizedBox(height: 10.0,),
              Container(
              width: MediaQuery.of(context).size.width / 2,
              child: LinearProgressIndicator(
              backgroundColor: Color(0xFFACB5FD),
              color: Color(0xFFf3f5f9),
              semanticsLabel: 'Linear progress indicator',
            ),
            ),
            SizedBox(height: 10.0,),
             Text('V.${ver.currentVersion.toString()} ', style: TextStyle(
              color: Colors.grey
            ),),
          ],
        ).withWidth(context.width()),
      ),
    );
  }
}


