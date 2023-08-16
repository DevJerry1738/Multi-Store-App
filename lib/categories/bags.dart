import 'package:flutter/material.dart';
import '../utilities/categ_list.dart';
import '../widgets/categ_widgets.dart';

class BagsCategory extends StatelessWidget {
  const BagsCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const CategHeaderLabel(
              HeaderLabel: 'Bags',
            ),
            Expanded(

              child: GridView.count(
                mainAxisSpacing: 40,
                crossAxisSpacing: 10,
                crossAxisCount: 3,
                children: List.generate(
                    bags.length -1,
                        (index) => Container(
                      child: SubCategModel(
                          maincategName: 'bags',
                          subcategName: bags[index+1],
                          assetName: 'images/bags/bags$index.jpg',
                          subcategLabel: bags[index+1]),
                    )),
              ),
            )
          ],
        )
    );
  }
}
