import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '/screens/404_screen.dart';
import '/screens/home_screen.dart';
import '/screens/lyrics_screen.dart';
import '/screens/result_screen.dart';
import 'helpers/bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //native splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //load .env file from the root dir that contains url and annon for supabase
  await dotenv.load(fileName: ".env");
  // supabase connection & fetch api key
  await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANNON_KEY']!);
  MobileAds.instance.initialize();
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      unknownRoute: GetPage(name: '/Confound', page: () => const NotFound()),
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: '/',
            page: () => const HomeScreen(),
            binding: HomeBinding(),
            transition: Transition.leftToRight,
            transitionDuration: const Duration(milliseconds: 200)),
        GetPage(
            name: '/result',
            page: () => const ResultScreen(),
            transition: Transition.leftToRight,
            transitionDuration: const Duration(milliseconds: 200)),
        GetPage(
            name: '/Confound',
            page: () => const NotFound(),
            transition: Transition.leftToRight,
            transitionDuration: const Duration(milliseconds: 200)),
        GetPage(
            name: '/lyrics',
            page: () => const LyricsScreen(),
            transition: Transition.circularReveal,
            transitionDuration: const Duration(milliseconds: 200)),
      ],
    );
  }
}
