
import 'package:flutter/cupertino.dart';

class AppLayouts {

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1200 &&
          MediaQuery.of(context).size.width >= 768;

  static getSize(BuildContext context){
    return MediaQuery.of(context).size;
  }
}