import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/api/api_service.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/provider/detail_page_provider.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/provider/home_page_provider.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/ui/home_page.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/ui/splash_screen.dart';

import 'common/styles.dart';
import 'model/restaurant.dart';
import 'ui/detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomePageProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_) => DetailPageProvider(apiService: ApiService())),
      ],
      child: MaterialApp(
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
          HomePage.routeName: (context) => HomePage(),
          DetailPage.routeName: (context) => DetailPage(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
        },
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
