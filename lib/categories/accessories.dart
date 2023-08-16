import 'package:flutter/material.dart';
import '../utilities/categ_list.dart';
import '../widgets/categ_widgets.dart';

class AccessoriesCategory extends StatelessWidget {
  const AccessoriesCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          const CategHeaderLabel(
            HeaderLabel: 'Accessories',
          ),
          Expanded(

            child: GridView.count(
              mainAxisSpacing: 40,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              children: List.generate(
                  accessories.length-1,
                      (index) => Container(
                    child: SubCategModel(
                        maincategName: 'accessories',
                        subcategName: accessories[index +1],
                        assetName: 'images/accessories/accessories$index.jpg',
                        subcategLabel: accessories[index+1]),
                  )),
            ),
          )
        ],
      )
    );
  }
}
