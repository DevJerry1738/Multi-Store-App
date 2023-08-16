import 'package:flutter/material.dart';
import '../utilities/categ_list.dart';
import '../widgets/categ_widgets.dart';

class ShoesCategory extends StatelessWidget {
  const ShoesCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const CategHeaderLabel(
              HeaderLabel: 'Shoes',
            ),
            Expanded(

              child: GridView.count(
                mainAxisSpacing: 40,
                crossAxisSpacing: 10,
                crossAxisCount: 3,
                children: List.generate(
                    shoes.length-1,
                        (index) => Container(
                      child: SubCategModel(
                          maincategName: 'shoes',
                          subcategName: shoes[index+1],
                          assetName: 'images/shoes/shoes$index.jpg',
                          subcategLabel: shoes[index+1]),
                    )),
              ),
            )
          ],
        )
    );
  }
}
