import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appBar_widgets.dart';

class SupplierOrders extends StatefulWidget {
  const SupplierOrders({Key? key}) : super(key: key);

  @override
  State<SupplierOrders> createState() => _SupplierOrdersState();
}

class _SupplierOrdersState extends State<SupplierOrders> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Orders'),
        leading: const AppBarBack(),
      ),
    );
  }
}
