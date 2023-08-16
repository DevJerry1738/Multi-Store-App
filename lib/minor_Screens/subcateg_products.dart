import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../widgets/appBar_widgets.dart';

class SubCategProducts extends StatefulWidget {
  final String subcategName;
  final String maincategName;

  const SubCategProducts(
      {Key? key, required this.subcategName, required this.maincategName})
      : super(key: key);

  @override
  State<SubCategProducts> createState() => _SubCategProductsState();
}

class _SubCategProductsState extends State<SubCategProducts> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincategname', isEqualTo: widget.maincategName)
        .where('subcategname', isEqualTo: widget.subcategName)
        .snapshots();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarBack(),
        title: AppBarTitle(title: widget.subcategName),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'This category has no items yet',
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Acme',
                    letterSpacing: 1.5),
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
                return ProductModel(
                  products: snapshot.data!.docs[index],
                );
              },
              staggeredTileBuilder: (context) => const StaggeredTile.fit(1),
            ),
          );
        },
      ),
    );
  }
}
