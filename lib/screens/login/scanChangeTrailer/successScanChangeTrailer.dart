import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/screens/login/dashboard/dashboard.dart';
import 'package:tms_app_mobile/screens/template/screens/PurchaseButton.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';

class SuccessChangeTrailer extends StatefulWidget {
  final bool? enableAppbar;

  SuccessChangeTrailer({this.enableAppbar = false});

  @override
  _SuccessChangeTrailerState createState() => _SuccessChangeTrailerState();
}

class _SuccessChangeTrailerState extends State<SuccessChangeTrailer> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
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
            Icon(Icons.arrow_back, size: 24).paddingAll(16).onTap(() {
              finish(context);
            }).visible(widget.enableAppbar!),
            SizedBox(
              width: context.width(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      decoration: boxDecorationDefault(shape: BoxShape.circle),
                      child: Image.asset('assets/success/success.png'),
                      height: 200.0,
                      ),
                  22.height,
                  Text(
                    'Ganti Trailer Berhasil !',
                    style: boldTextStyle(size: 22),
                    textAlign: TextAlign.center,
                  ),
                  16.height,
                 quizButton(
                        textContent: 'Kembali ke Menu Utama',
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
        ),
      ),
    );
  }
}
