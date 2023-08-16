import 'package:flutter/material.dart';
import 'package:multi_store_app/categories/bags.dart';
import 'package:multi_store_app/categories/kids.dart';
import 'package:multi_store_app/categories/shoes.dart';
import 'package:multi_store_app/categories/women.dart';

import '../categories/accessories.dart';
import '../categories/electronics.dart';
import '../categories/men.dart';
import '../widgets/fakeAppbar.dart';

List<ItemData> items = [
  ItemData(title: 'men'),
  ItemData(title: 'women'),
  ItemData(title: 'shoes'),
  ItemData(title: 'bags'),
  ItemData(title: 'accessories'),
  ItemData(title: 'electronics'),
  ItemData(title: 'kids'),
];

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    for (var element in items) {
      element.isSelected = false;
    }
    setState(() {
      items[0].isSelected = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: fakeAppbar(),
      ),
      body: SafeArea(
        child:  Container(

        color: Colors.pinkAccent,
        child: Stack(children: [
          Positioned(left: 0,bottom: 0,top: 0, child: SideNavigator(size)),
          Positioned( right: 0,bottom: 0,top: 0, child: CategView(size)),
        ]),
      ),
      ),

    );
  }

  Widget SideNavigator(Size size) {
    return SizedBox(
      width: size.width * 0.2,
      height: size.width * 1,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 100),
                  curve: Curves.bounceInOut);
            },
            child: Container(
              color: items[index].isSelected == true
                  ? Colors.white
                  : Colors.grey.shade300,
              height: 100,
              child: Center(child: Text(items[index].title)),
            ),
          );
        },
      ),
    );
  }

  Widget CategView(Size size) {
    return Container(
      width: size.width * 0.8,
      height: size.width * 1,
      color: Colors.white,
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          for (var element in items) {
            element.isSelected = false;
          }
          setState(() {
            items[value].isSelected = true;
          });
        },
        children: const [
          MenCategory(),
          WomenCategory(),
          ShoesCategory(),
          BagsCategory(),
          AccessoriesCategory(),
          ElectronicsCategory(),
          KidsCategory(),
        ],
      ),
    );
  }
}

class ItemData {
  String title;
  bool isSelected = false;
  ItemData({required this.title});
}
