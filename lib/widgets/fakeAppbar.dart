import 'package:flutter/material.dart';

import '../minor_Screens/search.dart';

class fakeAppbar extends StatelessWidget {
  const fakeAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SearchScreen()));
      },
      child: Container(
        height: 30,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.yellow),
            borderRadius: BorderRadius.circular(25.0)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              Text(
                'What are you looking for?',
                style: TextStyle(color: Colors.grey,fontSize: 15),
              ),
            ],
          ),
          Container(
            height: 30,
            width: 72,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                'Search',
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
