import 'package:flutter/material.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/model/restaurantss.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/ui/home.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/ui/splash_screen.dart';

import 'common/styles.dart';
import 'ui/detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReStoran App',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.black,
              secondary: secondaryColor,
            ),
        textTheme: myTextTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: secondaryColor,
            textStyle: const TextStyle(),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))),
          ),
        ),
      ),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        Home.routeName: (context) => const Home(),
        DetailPage.routeName: (context) => DetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
