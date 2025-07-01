import 'package:flutter/cupertino.dart';
import '../../feature/home/home_screen.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME_ROUTE:
        return CupertinoPageRoute(builder: (_) => HomeScreen());

      default:
      // return CupertinoPageRoute(builder: (_) => PaymentSuccessScreen());
        return CupertinoPageRoute(builder: (_) => HomeScreen());
    }
  }
}

//routes
const String HOME_ROUTE = '/HomeScreen';
