import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:multi_store_app/widgets/snackBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  String mainCategValue = 'select category';
  String subCategValue = 'subcategory';
  List<String> subCategList = [];

  late double price;
  late int quantity;
  late String productName;
  late String productId;
  late String productDescription;
  List<XFile>? imagesFIleList = [];
  List<String>? imagesUrlList = [];
  bool processing = false;

  dynamic _pickedImageError;
  final ImagePicker _picker = ImagePicker();
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  void pickProductImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
          maxHeight: 300, maxWidth: 300, imageQuality: 95);
      setState(() {
        imagesFIleList = pickedImages;
        MyMessage.showSnackBar(scaffoldKey, 'Image selected');
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  Widget previewImages() {
    if (imagesFIleList!.isNotEmpty) {
      return ListView.builder(
          itemCount: imagesFIleList!.length,
          itemBuilder: (context, index) {
            return Image.file(File(imagesFIleList![index].path));
          });
    } else {
      return const Center(
        child: Text(
          'You have not \n \n picked images yet!',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  void selectedMainCateg(String? value) {
    if (value == 'select category') {
      subCategList = [];
    } else if (value == 'men') {
      subCategList = men;
    } else if (value == 'women') {
      subCategList = women;
    } else if (value == 'electronics') {
      subCategList = electronics;
    } else if (value == 'accessories') {
      subCategList = accessories;
    } else if (value == 'shoes') {
      subCategList = shoes;
    }
    // else if(value == 'home & garden'){
    //   subCategList = homeandgarden;
    // }else if(value == 'beauty'){
    //   subCategList = beauty;
    // }
    else if (value == 'kids') {
      subCategList = kids;
    } else if (value == 'bags') {
      subCategList = bags;
    }
    print(value);

    setState(() {
      mainCategValue = value!;
      subCategValue = 'subcategory';
    });
  }

  Future<void> uploadImages() async {
    if (mainCategValue != 'select category' && subCategValue != 'subcategory') {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        if (imagesFIleList!.isNotEmpty) {
          setState(() {
            processing = true;
          });
          try {
            for (var image in imagesFIleList!) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref('product-images/${path.basename(image.path)}.jpg');
              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  imagesUrlList!.add(value);
                });
              });
            }
          } catch (e) {
            print(e);
          }
        } else {
          MyMessage.showSnackBar(scaffoldKey, 'please pick image(s)');
        }
      } else {
        MyMessage.showSnackBar(scaffoldKey, 'please fill all fields');
      }
    } else {
      setState(() {
        processing = false;
      });
      MyMessage.showSnackBar(scaffoldKey, 'please select category');
    }
  }

  void uploadDate() async {
    if (imagesUrlList!.isNotEmpty) {
      CollectionReference productRef =
          FirebaseFirestore.instance.collection('products');
      productId = const Uuid().v4();
      await productRef.doc(productId).set({
        'maincategname': mainCategValue,
        'subcategname': subCategValue,
        'price': price,
        'instock': quantity,
        'productname': productName,
        'productdescription': productDescription,
        'sid': FirebaseAuth.instance.currentUser!.uid,
        'productimages': imagesUrlList,
        'discount': 0,
        'productid': productId,
      }).whenComplete(() {
        setState(() {
          imagesFIleList = [];
          imagesUrlList = [];
          mainCategValue = 'select category';
          subCategList = [];
          processing = false;
        });
        formKey.currentState!.reset();
      });
    } else {
      setState(() {
        processing = false;
      });
      print('no image');
    }
  }

  void uploadProduct() async {
    await uploadImages().whenComplete(() {
      uploadDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: size.width * 0.5,
                        width: size.width * 0.5,
                        child: imagesFIleList != null
                            ? previewImages()
                            : const Center(
                                child: Text(
                                  'You have not \n \n picked images yet!',
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                        color: Colors.blueGrey.shade100,
                      ),
                      SizedBox(
                        height: size.width * 0.5,
                        width: size.width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  '* select main category',
                                  style: TextStyle(color: Colors.red),
                                ),
                                DropdownButton(
                                    iconSize: 40,
                                    iconEnabledColor: Colors.red,
                                    dropdownColor: Colors.yellow.shade400,
                                    value: mainCategValue,
                                    items: maincateg
                                        .map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      selectedMainCateg(value);
                                    }),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  '* select subcategory',
                                  style: TextStyle(color: Colors.red),
                                ),
                                DropdownButton(
                                    iconSize: 40,
                                    iconEnabledColor: Colors.red,
                                    iconDisabledColor: Colors.black,
                                    menuMaxHeight: 500,
                                    dropdownColor: Colors.yellow.shade400,
                                    disabledHint: const Text('select category'),
                                    value: subCategValue,
                                    items: subCategList
                                        .map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      print(value);
                                      setState(() {
                                        subCategValue = value!;
                                      });
                                    }),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                      height: 30,
                      child: Divider(
                        color: Colors.yellow,
                        thickness: 1.5,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.38,
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter pricw';
                            } else if (value.isValidPrice() != true) {
                              return 'Enter valid quantity';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            price = double.parse(value!);
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: textFormDecoration.copyWith(
                            label: const Text(
                              'Price :',
                            ),
                            hintText: 'Price..\$',
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter quantity';
                            } else if (value.isValidQuantity() != true) {
                              return 'Enter valid quantity';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            quantity = int.parse(value!);
                          },
                          keyboardType: TextInputType.number,
                          decoration: textFormDecoration.copyWith(
                            label: const Text(
                              'Quantity :',
                            ),
                            hintText: 'Add quantity',
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter product name';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            productName = value!;
                          },
                          maxLength: 100,
                          maxLines: 3,
                          decoration: textFormDecoration.copyWith(
                            label: const Text(
                              'Product Name :',
                            ),
                            hintText: 'Enter product name',
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter product description';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            productDescription = value!;
                          },
                          maxLength: 800,
                          maxLines: 5,
                          decoration: textFormDecoration.copyWith(
                            label: const Text(
                              'Product description :',
                            ),
                            hintText: 'Enter product description',
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: FloatingActionButton(
                onPressed: imagesFIleList!.isEmpty
                    ? () {
                        pickProductImages();
                      }
                    : () {
                        setState(() {
                          imagesFIleList = [];
                        });
                      },
                backgroundColor: Colors.yellow,
                child: imagesFIleList!.isEmpty
                    ? const Icon(
                        Icons.photo_library,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      ),
              ),
            ),
            FloatingActionButton(
              onPressed: processing == true
                  ? null
                  : () {
                      uploadProduct();
                    },
              backgroundColor: Colors.yellow,
              child: processing
                  ? const CircularProgressIndicator(
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.upload,
                      color: Colors.black,
                    ),
            )
          ],
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  label: const Text(
    'Price',
  ),
  hintText: 'Price..\$',
  labelStyle: TextStyle(color: Colors.purpleAccent),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.yellow, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.blueAccent, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
);

extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9]+[0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^([1-9]+[0-9]+[\.]*||([0][\.]))([0-9]{1,2})$')
        .hasMatch(this);
  }
}
