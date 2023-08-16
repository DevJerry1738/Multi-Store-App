import 'package:flutter/material.dart';

class formTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onchanged;
  //final TextEditingController controller;

  const formTextField({
    Key? key,
    required this.label,
    required this.hintText,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText=false,
    required this.validator,
    required this.onchanged
    //required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        onChanged: onchanged,
        //controller:controller ,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
            label:  Text(label),
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.purple, width: 1),
                borderRadius: BorderRadius.circular(25.0)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.deepPurpleAccent, width: 2),
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}

class photoIcon extends StatelessWidget {
  final IconData iconData;
  final Function()? onPressed;
  const photoIcon({
    Key? key, required this.iconData,required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)
          ),
          color: Colors.purpleAccent),
      child: IconButton(
        onPressed: onPressed,
        icon:  Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  const SubmitButton({
    Key? key,required this.label,required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Material(
          borderRadius: BorderRadius.circular(30),
          color: Colors.purpleAccent,
          child: MaterialButton(
            minWidth: double.infinity,
            onPressed: onPressed,
            child:  Text(
              label,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )),
    );
  }
}

class HaveAccount extends StatelessWidget {
  final String haveAccount;
  final String actionLabel;
  final Function() onPressed;
  const HaveAccount({
    Key? key,required this.haveAccount,required this.actionLabel,required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          haveAccount,
          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        TextButton(
            onPressed: onPressed,
            child:  Text(
              actionLabel,
              style: const TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ))
      ],
    );
  }
}

class HeaderLabel extends StatelessWidget {
  final String headerLabel;

  const HeaderLabel({
    Key? key,required this.headerLabel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          headerLabel,
          style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5),
        ),
        InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/welcome_screen');
            },
            child: const Icon(
              Icons.home,
            ))
      ],
    );
  }
}


extension EmailValidator on String{
  bool isValidEmail(){
    return RegExp(r'^[a-zA-Z0-9]+[\-\_\.]*[a-zA-Z0-9]*[@][a-zA-Z]{2,}[\.][a-zA-Z]{2,3}$').hasMatch(this);
  }
}