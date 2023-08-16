import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appBar_widgets.dart';

class CustomerOrders extends StatefulWidget {
  const CustomerOrders({Key? key}) : super(key: key);

  @override
  State<CustomerOrders> createState() => _CustomerOrdersState();
}

class _CustomerOrdersState extends State<CustomerOrders> {
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
