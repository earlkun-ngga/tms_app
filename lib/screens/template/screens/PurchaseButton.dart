import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tms_app_mobile/screens/template/utils/QuizColors.dart';
import '../utils/QuizColors.dart';
// import 'package:url_launcher/url_launcher.dart';

class PurchaseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: 'Purchase for more screen',
      color: quiz_colorPrimary,
      textStyle: boldTextStyle(color: Colors.white),
      shapeBorder: RoundedRectangleBorder(borderRadius: radius(10)),
      onTap: () {
              },
    );
  }
}
