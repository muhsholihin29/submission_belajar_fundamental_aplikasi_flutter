import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/model/restaurantss.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/widget/platform_widget.dart';

import 'detail_page.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  const Home({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const RestaurantList();
  }
}

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key});

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
    return FutureBuilder<String>(
      future:
          DefaultAssetBundle.of(context).loadString('assets/restaurants.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          // loading widget
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            // success widget
          } else if (snapshot.hasError) {
            // error widget
            return Center(child: Text(snapshot.error.toString()),
            );
          } else {
            // loading widget
            return Center(child: CircularProgressIndicator());
          }
        }
        final List<Restaurant> restaurants = parseRestaurants(snapshot.data);
        return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return _buildRestaurantItem(context, restaurants[index]);
            });
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Image.network(
          restaurant.pictureId,
          width: 100,
        ),
        title: Text(restaurant.name),
        subtitle: Text(restaurant.city),
        onTap: () {
          Navigator.pushNamed(context, DetailPage.routeName,
              arguments: restaurant);
        },
      ),
    );
  }
}
