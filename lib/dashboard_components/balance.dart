import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appBar_widgets.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({Key? key}) : super(key: key);

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Balance'),
        leading: const AppBarBack(),
      ),
    );
  }
}
