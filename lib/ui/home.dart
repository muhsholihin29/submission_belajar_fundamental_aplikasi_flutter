import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/widget/card_restaurant.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/widget/platform_widget.dart';

import '../api/api_service.dart';
import '../model/restaurant.dart';

class Home extends StatefulWidget  {
  static const routeName = '/home';
  const Home({super.key});

  @override
  State<StatefulWidget> createState() =>
    _Home();
}

class _Home extends State<Home> {

  late Future<RestaurantResult> _restaurant;

  @override
  void initState() {
    super.initState();
    _restaurant = ApiService().list();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReStoran App',
          style: TextStyle(color: Color(0xffffffff)),),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurant App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future: _restaurant,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          // loading widget
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.restaurants?.length,
              itemBuilder: (context, index) {
                var restaurant = snapshot.data?.restaurants?[index];
                return CardRestaurant(restaurant: restaurant!);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()),
            );
          } else {
            return const Material(child: Text(''));
          }
        }
      },
    );
  }
}
