import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appBar_widgets.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'WishList'),
        leading: const AppBarBack(),
      ),
    );
  }
}
