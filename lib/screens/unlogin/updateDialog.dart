import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/models/Version_model.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizWidget.dart';
import 'package:tms_app_mobile/screens/unlogin/prosesDownloadUpdate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tms_app_mobile/config/apiConfig.dart' as apiconf;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class UpdatePage extends StatefulWidget {
  @override
  _UpdatePageState createState() => _UpdatePageState();
  String newVersion;

  UpdatePage(this.newVersion);
}

class _UpdatePageState extends State<UpdatePage> {


  Version ver = Version();

  @override
  void initState() {
    super.initState();
   
   ver.getInfoIDDownload().then((value) => {
     print(value),
     print(value['data']['value']),
   });
  }



  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: context.width(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                   Text(
                    'Update Versi Aplikasi\n(di wajibkan)',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15.0,),
                  Container(
                      decoration: boxDecorationDefault(shape: BoxShape.circle),
                      child: Image.asset('assets/menu_image/download_icon.png'),
                      height: 200.0,
                      ),
                  22.height,
                   Text(
                    'Terdeteksi Versi baru di server, dengan melakukan update, dapat memperbaiki kekurangan di versi sebelumnya',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  16.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Chip(label: Text('V.${ver.currentVersion}', style: TextStyle(
                        color: Colors.white, 
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                        ),),
                        backgroundColor: Colors.brown,),
                        VerticalDivider(),
                        Chip(label: Icon(Icons.arrow_forward_rounded,
                        
                        ),
                        backgroundColor: quiz_app_background,),
                        VerticalDivider(),
                         Chip(label: Text('V.${widget.newVersion}', style: TextStyle(
                        color: Colors.white, 
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                        ),),
                        backgroundColor: Colors.greenAccent,),
                    ],
                  ),
                  16.height,
                  
                 FutureBuilder(
                   
                   future: ver.getInfoIDDownload(),
                   builder: (BuildContext context, AsyncSnapshot snapshot){


                     if(snapshot.data == null)
                     {
                      return  CircularProgressIndicator(
                    backgroundColor: Color(0xFFACB5FD),
                    color: Color(0xFFf3f5f9),
                  );
                       
                     } else {
                       return quizButton(
                        textContent: 'Update',
                        onPressed: () {
                          //  UploadProcess('${apiconf.urlApi}resources/apk/${snapshot.data['data']['value']}');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UploadProcess('${apiconf.urlApi}resources/apk/${snapshot.data['data']['value']}', '${widget.newVersion}')),);
                        });

                     }
                 }),
                 SizedBox(height: 20.0,),
                 Chip(
                        label: Text('Server URL :  ${apiconf.urlApi}', style: TextStyle(
                        color: Colors.white, 
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                        ),),
                        backgroundColor: Colors.grey[30],
                      ),
                ],
              ),
            ).paddingAll(16),
          ],
        ),
      ),
    );
  }
}
