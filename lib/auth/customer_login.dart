import 'package:flutter/material.dart';
import '../widgets/form_widgets.dart';
import '../widgets/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomerLogin extends StatefulWidget {
  const CustomerLogin({Key? key}) : super(key: key);

  @override
  State<CustomerLogin> createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<CustomerLogin> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;

  bool processing = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool passwordVisibility = false;

  void logIn() async {
    setState(() {
      processing = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        _formKey.currentState!.reset();

        Navigator.pushReplacementNamed(context, '/customer_home');
      } on FirebaseAuthException catch (e) {
        setState(() {
          processing = false;
        });
        MyMessage.showSnackBar(scaffoldKey, 'Log in error: error$e');
      }
    } else {
      setState(() {
        processing = false;
      });
      MyMessage.showSnackBar(scaffoldKey, 'Please fill all fields');
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: HeaderLabel(
                          headerLabel: 'Log In',
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'forgot password?',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18, fontStyle: FontStyle.italic),
                          )),
                      HaveAccount(
                        haveAccount: 'Don\'t have account? ',
                        actionLabel: 'Sign Up',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/customer_signup');
                        },
                      ),
                      processing
                          ? const CircularProgressIndicator(color: Colors.purpleAccent,)
                          : SubmitButton(
                              label: 'Log In',
                              onPressed: () {
                                logIn();
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
