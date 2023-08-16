import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appBar_widgets.dart';

class EditBusiness extends StatefulWidget {
  const EditBusiness({Key? key}) : super(key: key);

  @override
  State<EditBusiness> createState() => _EditBusinessState();
}

class _EditBusinessState extends State<EditBusiness> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Edit Business'),
        leading: const AppBarBack(),
      ),
    );
  }
}
