import 'package:word_scramble_frontend/ui/homepage/homepage.dart';
import 'package:word_scramble_frontend/ui/login/login.dart';
import 'package:word_scramble_frontend/ui/splash_screen/splash_screen.dart';

class Routes {
  static final routes = {
    "/": (context) => SplashScreen(),
    "/home": (context) => Homepage(),
    "/login": (context) => Login()
  };
}
