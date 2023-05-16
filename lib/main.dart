import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/res/global.dart';
import 'package:flutter_news_app/views/screens/splashScreen.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  Global.isVisited = prefs.getBool('isVisited') ?? false;
  Global.isLogged = prefs.getBool('isLogged') ?? false;

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      getPages: [
        GetPage(name: '/', page: ()=> const SplashScreen()),
      ],
    ),
  );
}