import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appBar_widgets.dart';

class MyStore extends StatefulWidget {
  const MyStore({Key? key}) : super(key: key);

  @override
  State<MyStore> createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
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
