import 'package:flutter/material.dart';

import 'package:multi_store_app/widgets/appBar_widgets.dart';

import '../widgets/yellowbutton.dart';



class CartScreen extends StatefulWidget {
  final Widget? back ;
  const CartScreen({Key? key, this.back}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Scaffold(
          appBar: AppBar(
            leading:  widget.back,
            elevation: 0,
            backgroundColor: Colors.white,
            title: const AppBarTitle(title: 'Cart'),
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.delete_forever,color: Colors.black,))
            ],
          ),
          body:  Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Your cart is empty',
              style: TextStyle(
                fontSize: 30,
              ),),
              const SizedBox(
                height: 50,
              ),
              Material(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width*0.6,
                  onPressed: (){
                    //since we want to go back to profile page we check if cart was
                    //called from profile(pop is true) else it pushes to customer home
                    Navigator.canPop(context)?Navigator.pop(context):
                    Navigator.pushReplacementNamed(
                        context, '/customer_home');
                  },
                  child: const Text('Continue Shopping',style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),),),
              ),
            ],
          ),),
          bottomSheet:   Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Total: \$ ',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    Text(
                      '00.00',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                      ),
                    ),
                  ],
                ),
              ),

              YellowButton( label: 'CHECK OUT',onPressed: (){},width: 0.45,),

            ],
          ),
        ),
      ),
    );
  }
}


