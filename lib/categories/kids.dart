import 'package:flutter/material.dart';
import '../utilities/categ_list.dart';
import '../widgets/categ_widgets.dart';

class KidsCategory extends StatelessWidget {
  const KidsCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const CategHeaderLabel(
              HeaderLabel: 'Kids',
            ),
            Expanded(

              child: GridView.count(
                mainAxisSpacing: 40,
                crossAxisSpacing: 10,
                crossAxisCount: 3,
                children: List.generate(
                    kids.length-1,
                        (index) => Container(
                      child: SubCategModel(
                          maincategName: 'kids',
                          subcategName: kids[index+1],
                          assetName: 'images/kids/kids$index.jpg',
                          subcategLabel: kids[index+1]),
                    )),
              ),
            )
          ],
        )
    );
  }
}
