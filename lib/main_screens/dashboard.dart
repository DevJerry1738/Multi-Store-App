import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/dashboard_components/balance.dart';
import 'package:multi_store_app/dashboard_components/edit_business.dart';
import 'package:multi_store_app/dashboard_components/manage_products.dart';
import 'package:multi_store_app/dashboard_components/my_store.dart';
import 'package:multi_store_app/dashboard_components/stats.dart';
import 'package:multi_store_app/dashboard_components/supplier_orders.dart';
import 'package:multi_store_app/widgets/appBar_widgets.dart';

import '../widgets/myDialogBox.dart';

List<String> labels = [
  'my store',
  'orders',
  'edit profile',
  'manage products',
  'balance',
  'stats'
];

const dashboardCateg = [
  MyStore(),
  SupplierOrders(),
  EditBusiness(),
  ManageProducts(),
  BalanceScreen(),
  StatsScreen(),
];

List<IconData> icons = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart
];

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                MyDialog().showDialogBox(
                    context: context,
                    title: 'Log out',
                    content: 'Confirm logout',
                    tapNo: () {
                      Navigator.pop(context);
                    },
                    tapYes: () async {
                      await FirebaseAuth.instance
                          .signOut();
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, '/welcome_screen');
                    });
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
          mainAxisSpacing: 50,
          crossAxisSpacing: 50,
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => dashboardCateg[index],
                  ),
                );
              },
              child: Card(
                shadowColor: Colors.purpleAccent.shade200,
                elevation: 20,
                color: Colors.blueGrey.withOpacity(0.7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      icons[index],
                      color: Colors.yellowAccent,
                      size: 50,
                    ),
                    Text(
                      labels[index].toUpperCase(),
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Acme',
                          color: Colors.yellowAccent,
                          letterSpacing: 2),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
