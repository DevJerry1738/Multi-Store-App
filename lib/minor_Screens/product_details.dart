import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:multi_store_app/widgets/yellowbutton.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../models/product_model.dart';
import 'image_fullscreen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final dynamic proList;
  const ProductDetailsScreen({Key? key, required this.proList})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late List<dynamic> imagesList = widget.proList['productimages'];

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincategname', isEqualTo: widget.proList['maincategname'])
        .where('subcategname', isEqualTo: widget.proList['subcategname'])
        .snapshots();
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ImageFullScreen(
                                imagesList: imagesList,
                              ))));
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: CarouselSlider.builder(
                          itemCount: imagesList.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) {
                            return Image.network(imagesList[itemIndex]);
                          },
                          options: CarouselOptions()),
                    ),
                    Positioned(
                      left: 15,
                      top: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 15,
                      top: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 8, right: 8, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.proList['productname'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              '\$ ',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              widget.proList['price'].toStringAsFixed(2),
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.red,
                              size: 30,
                            )),
                      ],
                    ),
                    Text(
                      (widget.proList['instock'].toString()) +
                          (' items available5'),
                      style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const ProDetailsHeader(
                      title: ' Item Description ',
                    ),
                    Text(
                      widget.proList['productdescription'],
                      textScaleFactor: 1.1,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey.shade600,
                      ),
                    ),
                    const ProDetailsHeader(
                      title: ' Similar Items ',
                    ),
                    SizedBox(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _productsStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                              staggeredTileBuilder: (context) =>
                                  const StaggeredTile.fit(1),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.store)),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.shopping_cart)),
                  ],
                ),
                YellowButton(
                    label: 'ADD TO CART', onPressed: () {}, width: 0.55)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProDetailsHeader extends StatelessWidget {
  final String title;
  const ProDetailsHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.yellow.shade900,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 50,
                  child: Divider(
                    color: Colors.yellow.shade900,
                    thickness: 1,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
