import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/yellowbutton.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

final colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

const colorizeTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'Acme',
);

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  bool processing = false;
  late AnimationController _controller;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  late String _uid;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/inapp/bgimage.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText('Welcome',
                      textStyle: colorizeTextStyle,
                      colors: [Colors.white, Colors.white]),
                  ColorizeAnimatedText('Leo Cosmetics',
                      textStyle: colorizeTextStyle, colors: colorizeColors),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
              ),
              const SizedBox(
                  height: 120,
                  width: 200,
                  child: Image(
                      image: AssetImage(
                    'images/inapp/logo.jpg',
                  ))),
              SizedBox(
                height: 80,
                child: DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Acme',
                      color: Colors.white),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('Buy'),
                      RotateAnimatedText('Cosmetics')
                    ],
                    repeatForever: true,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                            color: Colors.grey),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Suppliers only.',
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                            color: Colors.grey),
                        child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AnimatedLogo(controller: _controller),
                                YellowButton(
                                  label: 'Log in',
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/supplier_login');
                                  },
                                  width: 0.25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: YellowButton(
                                    label: 'Sign up',
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/supplier_signup');
                                    },
                                    width: 0.25,
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                        color: Colors.grey),
                    child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: YellowButton(
                                label: 'Log in',
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/customer_login');
                                },
                                width: 0.25,
                              ),
                            ),
                            YellowButton(
                              label: 'Sign up',
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/customer_signup');
                              },
                              width: 0.25,
                            ),
                            AnimatedLogo(controller: _controller),
                          ],
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white38.withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      socialsLogin(
                        child: const Image(
                            image: AssetImage('images/inapp/google.jpg')),
                        label: 'Google',
                        onPressed: () {},
                      ),
                      socialsLogin(
                        child: const Image(
                            image: AssetImage('images/inapp/facebook.jpg')),
                        label: 'Facebook',
                        onPressed: () {},
                      ),
                      socialsLogin(
                        child: const Icon(
                          Icons.person,
                          color: Colors.lightBlue,
                          size: 50,
                        ),
                        label: 'Guest',
                        onPressed: () async {
                          await FirebaseAuth.instance
                              .signInAnonymously()
                              .whenComplete(() async {
                            _uid = FirebaseAuth.instance.currentUser!.uid;
                            await customers.doc(_uid).set({
                              'name': '',
                              'email': '',
                              'profileimage': '',
                              'phone': '',
                              'address': '',
                              'cid': _uid
                            });
                          });

                          setState(() {
                            processing = true;
                          });
                          Navigator.pushReplacementNamed(
                              context, '/customer_home');
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({
    Key? key,
    required AnimationController controller,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: const Image(
          image: AssetImage(
        'images/inapp/logo.jpg',
      )),
    );
  }
}

class socialsLogin extends StatelessWidget {
  final Widget child;
  final String label;
  final Function() onPressed;

  const socialsLogin(
      {Key? key,
      required this.child,
      required this.label,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            SizedBox(height: 50, width: 50, child: child),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
