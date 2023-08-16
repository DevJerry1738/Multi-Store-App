import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/form_widgets.dart';
import '../widgets/snackBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// final TextEditingController _nameController = TextEditingController();
// final TextEditingController _emailController = TextEditingController();
// final TextEditingController _passwordController = TextEditingController();
class SupplierRegister extends StatefulWidget {
  const SupplierRegister({Key? key}) : super(key: key);

  @override
  State<SupplierRegister> createState() => _SupplierRegisterState();
}

class _SupplierRegisterState extends State<SupplierRegister> {
  final _auth = FirebaseAuth.instance;

  XFile? _imageFile;
  dynamic _pickedImageError;
  final ImagePicker _picker = ImagePicker();

  late String storeLogo;
  late String storeName;
  late String email;
  late String password;
  late String _uid;
  bool processing = false;

  CollectionReference suppliers =
  FirebaseFirestore.instance.collection('suppliers');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
  GlobalKey<ScaffoldMessengerState>();

  bool passwordVisibility = false;

  void signUp() async {
    setState(() {
      processing = true;
    });
    if (_formKey.currentState!.validate()) {
      if (_imageFile != null) {
        try {
          await _auth.createUserWithEmailAndPassword(
              email: email, password: password);

          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref('store-logos/$email.jpg');
          await ref.putFile(File(_imageFile!.path));

          storeLogo = await ref.getDownloadURL();
          _uid = FirebaseAuth.instance.currentUser!.uid;

          await suppliers.doc(_uid).set({
            'storename': storeName,
            'email': email,
            'storelogo': storeLogo,
            'phone': '',
            'sid': _uid,
            'coverimage':'',
          });

          _formKey.currentState!.reset();
          setState(() {
            _imageFile = null;
          });

          Navigator.pushReplacementNamed(context, '/supplier_login');
        } on FirebaseAuthException catch (e) {
          setState(() {
            processing = false;
          });
          MyMessage.showSnackBar(scaffoldKey, 'sign up error$e');
        }
      } else {
        setState(() {
          processing = false;
        });
        MyMessage.showSnackBar(scaffoldKey, 'Please select image');
      }
    } else {
      setState(() {
        processing = false;
      });
      MyMessage.showSnackBar(scaffoldKey, 'Please fill all fields');
    }
  }

  void _pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void _pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
        MyMessage.showSnackBar(scaffoldKey, 'Image selected');
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: HeaderLabel(
                          headerLabel: 'Sign Up',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 30.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.purpleAccent,
                                radius: 50,
                                backgroundImage: _imageFile == null
                                    ? null
                                    : FileImage(File(_imageFile!.path)),
                              ),
                            ),
                            Column(
                              children: [
                                photoIcon(
                                  iconData: Icons.camera_alt,
                                  onPressed: () {
                                    _pickImageFromCamera();
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                photoIcon(
                                  iconData: Icons.photo,
                                  onPressed: () {
                                    _pickImageFromGallery();
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      formTextField(
                        onchanged: (value) {
                          //storing data to variables using onChanged function
                          storeName = value;
                        },
                        //controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter full name';
                          }
                          return null;
                        },
                        label: 'Store Name',
                        hintText: 'Enter your store\'s name',
                      ),
                      formTextField(
                        onchanged: (value) {
                          email = value;
                        },
                        //controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Email';
                          } else if (value.isValidEmail() == false) {
                            return 'invalid email';
                          } else if (value.isValidEmail() == true) {
                            return null;
                          }
                          return null;
                        },
                        label: 'Email Address',
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      formTextField(
                        onchanged: (value) {
                          password = value;
                        },
                        //controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                        obscureText: passwordVisibility,
                        label: 'Password',
                        hintText: 'Enter your Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                            icon: Icon(
                              passwordVisibility
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.purpleAccent,
                            )),
                      ),
                      HaveAccount(
                        haveAccount: 'Already have account? ',
                        actionLabel: 'Log In',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/supplier_login');
                        },
                      ),
                      processing
                          ? const CircularProgressIndicator(color: Colors.purpleAccent,)
                          : SubmitButton(
                        label: 'Sign Up',
                        onPressed: () {
                          signUp();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
