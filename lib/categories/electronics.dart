import 'package:flutter/material.dart';
import '../utilities/categ_list.dart';
import '../widgets/categ_widgets.dart';

class ElectronicsCategory extends StatelessWidget {
  const ElectronicsCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          const CategHeaderLabel(
            HeaderLabel: 'Electronics',
          ),
          Expanded(

            child: GridView.count(
              mainAxisSpacing: 40,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              children: List.generate(
                  electronics.length-1,
                      (index) => Container(
                    child: SubCategModel(
                        maincategName: 'electronics',
                        subcategName: electronics[index+1],
                        assetName: 'images/electronics/electronics$index.jpg',
                        subcategLabel: electronics[index+1]),
                  )),
            ),
          )
        ],
      )
    );
  }
}
