import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/product_model.dart';

class KidsGalleryScreen extends StatefulWidget {
  const KidsGalleryScreen({Key? key}) : super(key: key);

  @override
  State<KidsGalleryScreen> createState() => _KidsGalleryScreenState();
}

class _KidsGalleryScreenState extends State<KidsGalleryScreen> {
  final Stream<QuerySnapshot> _productsStream =
  FirebaseFirestore.instance.collection('products').where('maincategname',isEqualTo: 'kids').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(snapshot.data!.docs.isEmpty){
          return const Center(
            child: Text('This category has no items yet',style: TextStyle(
                fontSize: 26,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontFamily: 'Acme',
                letterSpacing: 1.5
            ),
              textAlign: TextAlign.center,
            ),
          );
        }

        return SingleChildScrollView(
          child: StaggeredGridView.countBuilder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return ProductModel(products: snapshot.data!.docs[index],);
            },
            staggeredTileBuilder: (context) => const StaggeredTile.fit(1),
          ),
        );

      },
    );
  }
}
