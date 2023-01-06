import 'package:flutter/material.dart';

class ItemMenuTile extends StatelessWidget {
  const ItemMenuTile({
    Key? key,
    required this.menu,
  }) : super(key: key);

  final String menu;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.red,
        ),
        child: Text(
          menu,
        ),
      ),
    );
  }
}
