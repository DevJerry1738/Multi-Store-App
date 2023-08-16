import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appBar_widgets.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'My Store'),
        leading: const AppBarBack(),
      ),
    );
  }
}
