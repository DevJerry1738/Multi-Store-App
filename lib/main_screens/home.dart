import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/galleries/accessories_gallery.dart';
import 'package:multi_store_app/galleries/bags_gallery.dart';
import 'package:multi_store_app/galleries/kids_gallery.dart';
import 'package:multi_store_app/galleries/shoes_gallery.dart';
import 'package:multi_store_app/galleries/women_gallery.dart';

import '../galleries/electronics_gallery.dart';
import '../galleries/men_gallery.dart';
import '../widgets/fakeAppbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100.withOpacity(0.5),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const fakeAppbar(),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.yellow,
            tabs: [
              RepeatedTabs(
                title: 'Men',
              ),
              RepeatedTabs(
                title: 'Women',
              ),
              RepeatedTabs(
                title: 'Shoes',
              ),
              RepeatedTabs(
                title: 'Bags',
              ),
              RepeatedTabs(
                title: 'Accessories',
              ),
              RepeatedTabs(
                title: 'Electronics',
              ),
              RepeatedTabs(
                title: 'Kids',
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          MenGalleryScreen(),
          WomenGalleryScreen(),
          ShoesGalleryScreen(),
          BagsGalleryScreen(),
          AccessoriesGalleryScreen(),
          ElectronicsGalleryScreen(),
          KidsGalleryScreen(),
        ]),
      ),
    );
  }
}

class RepeatedTabs extends StatelessWidget {
  final String title;

  const RepeatedTabs({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: Colors.grey.shade600),
    );
  }
}
