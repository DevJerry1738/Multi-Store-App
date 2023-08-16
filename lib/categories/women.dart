import 'package:flutter/material.dart';
import '../utilities/categ_list.dart';
import '../widgets/categ_widgets.dart';

class WomenCategory extends StatelessWidget {
  const WomenCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          const CategHeaderLabel(
            HeaderLabel: 'Women',
          ),
          Expanded(

            child: GridView.count(
              mainAxisSpacing: 40,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              children: List.generate(
                  women.length-1,
                      (index) => Container(
                    child: SubCategModel(
                        maincategName: 'women',
                        subcategName: women[index+1],
                        assetName: 'images/women/women$index.jpg',
                        subcategLabel: women[index+1]),
                  )),
            ),
          )
        ],
      )
    );
  }
}
