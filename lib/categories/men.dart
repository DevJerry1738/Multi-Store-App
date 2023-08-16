import 'package:flutter/material.dart';
import '../utilities/categ_list.dart';
import '../widgets/categ_widgets.dart';

class MenCategory extends StatelessWidget {
  const MenCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const CategHeaderLabel(
              HeaderLabel: 'Men',
            ),
            Expanded(
              child: GridView.count(
                mainAxisSpacing: 40,
                crossAxisSpacing: 10,
                crossAxisCount: 3,
                children: List.generate(
                    men.length - 1,
                    (index) => Container(
                          child: SubCategModel(
                              maincategName: 'men',
                              subcategName: men[index + 1],
                              assetName: 'images/men/men$index.jpg',
                              subcategLabel: men[index + 1]),
                        )),
              ),
            )
          ],
        ));
  }
}
