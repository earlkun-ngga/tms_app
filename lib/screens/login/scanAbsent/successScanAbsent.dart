import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/screens/login/dashboard/dashboard.dart';
import 'package:tms_app_mobile/screens/template/screens/PurchaseButton.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizWidget.dart';
import 'package:tms_app_mobile/screens/template/utils/AppWidget.dart';

class SuccessAbsent extends StatefulWidget {
  final bool? enableAppbar;

  SuccessAbsent({this.enableAppbar = false});

  @override
  _SuccessAbsentScreenState createState() => _SuccessAbsentScreenState();
}

class _SuccessAbsentScreenState extends State<SuccessAbsent> {
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
                    'scan_absent.success'.tr(),
                    style: boldTextStyle(size: 22),
                    textAlign: TextAlign.center,
                  ),
                  16.height,
                 quizButton(
                        textContent: 'scan_absent.kembali_ke_dashboard'.tr(),
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
