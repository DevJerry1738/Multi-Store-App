import 'package:flutter/material.dart';
import '../minor_Screens/subcateg_products.dart';

class Sliderbar extends StatelessWidget {
  final String maincategName;
  const Sliderbar({Key? key, required this.maincategName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.brown.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30)),
          child: RotatedBox(
            quarterTurns: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                maincategName == 'bags'
                    ? const Text('')
                    : const Text('<<', style: style),
                Text(maincategName.toUpperCase(), style: style),
                maincategName == 'men'
                    ? const Text('')
                    : const Text('>>', style: style)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubCategModel extends StatelessWidget {
  final String maincategName;
  final String subcategName;
  final String assetName;
  final String subcategLabel;
  const SubCategModel(
      {Key? key,
      required this.maincategName,
      required this.subcategName,
      required this.assetName,
      required this.subcategLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubCategProducts(
                    subcategName: subcategName, maincategName: maincategName)));
      },
      child: Column(
        children: [
          SizedBox(
            child: Image(image: AssetImage(assetName)),
            height: 70,
            width: 70,
          ),
          Expanded(child: Text(subcategLabel))
        ],
      ),
    );
  }
}

class CategHeaderLabel extends StatelessWidget {
  final String HeaderLabel;
  const CategHeaderLabel({Key? key, required this.HeaderLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Text(
        HeaderLabel,
        style: const TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

const style = TextStyle(
    color: Colors.brown,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5);
