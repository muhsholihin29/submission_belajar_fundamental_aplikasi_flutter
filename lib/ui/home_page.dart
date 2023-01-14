import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/widget/card_restaurant.dart';
import 'package:submission_belajar_fundamental_aplikasi_flutter/widget/platform_widget.dart';

import '../provider/home_page_provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  TextEditingController textSearchController = TextEditingController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          searchField(context),
          Expanded(child: _buildList()),
        ],
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurant App'),
        transitionBetweenRoutes: false,
      ),
      child: Column(
        children: [
          searchField(context),
          Expanded(child: _buildList()),
        ],
      ),
    );
  }

  Widget searchField(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onEditingComplete: () {
          var provider =
          Provider.of<HomePageProvider>(context, listen: false);
          provider.search(textSearchController.text);
        },
        controller: textSearchController,
        decoration: const InputDecoration(
            labelText: "Cari",
            hintText: "Masukan Nama Restoran atau Menu",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<HomePageProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          // loading widget
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants?.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants?[index];
              return CardRestaurant(restaurant: restaurant!);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Text(state.message),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Material(child: Text(''));
        }
      },
    );
  }
}
