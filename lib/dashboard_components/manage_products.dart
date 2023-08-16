import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appBar_widgets.dart';

class ManageProducts extends StatefulWidget {
  const ManageProducts({Key? key}) : super(key: key);

  @override
  State<ManageProducts> createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Manage Products'),
        leading: const AppBarBack(),
      ),
    );
  }
}
