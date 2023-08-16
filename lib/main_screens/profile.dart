import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/customer_screens/customer_orders.dart';
import 'package:multi_store_app/customer_screens/wishlist.dart';
import 'package:multi_store_app/main_screens/cart.dart';
import 'package:multi_store_app/widgets/appBar_widgets.dart';

import '../widgets/myDialogBox.dart';

class ProfileScreen extends StatefulWidget {
  final String documentId;
  const ProfileScreen({Key? key,required this.documentId}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference customers = FirebaseFirestore.instance.collection('customers');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: customers.doc(widget.documentId).get(),
    builder:
    (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

    if (snapshot.hasError) {
    return const Text("Something went wrong");
    }

    if (snapshot.hasData && !snapshot.data!.exists) {
    return const Text("Document does not exist");
    }

    if (snapshot.connectionState == ConnectionState.done) {
    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
    return  /*Text("Full Name: ${data['full_name']} ${data['last_name']}");*/

    Scaffold(
    backgroundColor: Colors.grey.shade300,
    body: Stack(
    children: [
    Container(
    height: 180,
    decoration: const BoxDecoration(
    gradient: LinearGradient(colors: [Colors.yellow, Colors.brown]),
    ),
    ),
    CustomScrollView(
    physics: const BouncingScrollPhysics(
    parent: AlwaysScrollableScrollPhysics(),
    ),
    slivers: [
    SliverAppBar(
    pinned: true,
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.white,
    expandedHeight: 140,
    flexibleSpace: LayoutBuilder(
    builder: (context, constraints) {
    return FlexibleSpaceBar(
    title: AnimatedOpacity(
    duration: const Duration(milliseconds: 100),
    opacity: constraints.biggest.height <= 120 ? 1 : 0,
    child: const Text(
    'Account',
    style: TextStyle(color: Colors.black),
    ),
    ),
    background: Container(
    decoration: const BoxDecoration(
    gradient: LinearGradient(
    colors: [Colors.yellow, Colors.brown]),
    ),
    child: Padding(
    padding: const EdgeInsets.only(top: 25.0, left: 30.0),
    child: Row(
    children: [
      data['profileimage']==''?const CircleAvatar(
         radius: 50,
         backgroundImage:
         AssetImage('images/inapp/guest.jpg'),
         ):CircleAvatar(
        radius: 50,
        backgroundImage:
        NetworkImage(data['profileimage']),
        ),

    // const CircleAvatar(
    // radius: 50,
    // backgroundImage:
    // AssetImage('images/inapp/guest.jpg'),
    // ),
    Padding(
    padding: const EdgeInsets.only(left: 25.0),
    child: Text(data['name']==''?'guest'.toUpperCase(): data['name'].toUpperCase(),
    style: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600),
    ),
    )
    ],
    ),
    ),
    ),
    );
    },
    ),
    ),
    SliverToBoxAdapter(
    child: Column(
    children: [
    Container(
    height: 80,
    width: MediaQuery.of(context).size.width * 0.9,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(50),
    ),
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Container(
    decoration: const BoxDecoration(
    color: Colors.black54,
    borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(30),
    topLeft: Radius.circular(30),
    ),
    ),
    child: TextButton(
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => const CartScreen(
    back: AppBarBack(),
    ),
    ),
    );
    },
    child: SizedBox(
    width:
    MediaQuery.of(context).size.width * 0.2,
    height: 40,
    child: const Center(
    child: Text(
    'Cart',
    style: TextStyle(
    color: Colors.yellow, fontSize: 20),
    ),
    ),
    ),
    ),
    ),
    Container(
    decoration: const BoxDecoration(
    color: Colors.yellow,
    ),
    child: TextButton(
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>
    const CustomerOrders(),
    ),
    );
    },
    child: SizedBox(
    width:
    MediaQuery.of(context).size.width * 0.2,
    height: 40,
    child: const Center(
    child: Text(
    'Orders',
    style: TextStyle(
    color: Colors.black54, fontSize: 20),
    ),
    ),
    ),
    ),
    ),
    Container(
    decoration: const BoxDecoration(
    color: Colors.black54,
    borderRadius: BorderRadius.only(
    bottomRight: Radius.circular(30),
    topRight: Radius.circular(30),
    ),
    ),
    child: TextButton(
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>
    const WishlistScreen(),
    ),
    );
    },
    child: SizedBox(
    width:
    MediaQuery.of(context).size.width * 0.2,
    height: 40,
    child: const Center(
    child: Text(
    'Wishlist',
    style: TextStyle(
    color: Colors.yellow, fontSize: 20),
    ),
    ),
    ),
    ),
    ),
    ],
    ),
    ),
    ),
    Container(
    color: Colors.grey.shade300,
    child: Column(
    children: [
    const SizedBox(
    height: 150,
    child: Image(
    image: AssetImage('images/inapp/logo.jpg'),
    ),
    ),
    const ProfileHeader(
    headerText: '  Account Info  ',
    ),
    Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
    height: 280,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    ),
    child:  Column(
    children: [
    RepeatedListTile(
    title: 'Email Address',
    subTitle:data['email']==''?'example@email.com': data['email'],
    iconData: Icons.email),
    ProfileDivider(),
    RepeatedListTile(
    title: 'Phone Number',
    subTitle:data['phone']==''?'+123456789': data['phone'],
    iconData: Icons.phone),
    ProfileDivider(),
    RepeatedListTile(
    title: 'Address',
    subTitle:data['address']==''?'exaample: New Jersey, USA': data['address'],
    iconData: Icons.location_pin),
    ],
    ),
    ),
    ),
    const ProfileHeader(
    headerText: '  Account Settings  '),
    Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
    height: 280,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
    children: [
    RepeatedListTile(
    title: 'Edit Profile',
    iconData: Icons.edit,
    onPressed: () {}),
    const ProfileDivider(),
    RepeatedListTile(
    title: 'Change Password',
    iconData: Icons.lock,
    onPressed: () {}),
    const ProfileDivider(),
    RepeatedListTile(
    title: 'Logout',
    iconData: Icons.logout,
    onPressed: () {
    MyDialog().showDialogBox(
    context: context,
    title: 'Log out',
    content: 'Confirm logout',
    tapNo: () {
    Navigator.pop(context);
    },
    tapYes: () async {
    await FirebaseAuth.instance
        .signOut();
    Navigator.pop(context);
    Navigator.pushReplacementNamed(
    context, '/welcome_screen');
    });
    }),
    ],
    ),
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    )
    ],
    ),
    ],
    ),
    );
    }

    return Center(child: CircularProgressIndicator(color: Colors.purpleAccent,),);
    }




    );}
}

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(
        color: Colors.yellow,
        thickness: 1,
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function()? onPressed;
  final IconData iconData;

  const RepeatedListTile(
      {Key? key,
      required this.title,
      this.subTitle = '',
      required this.iconData,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        leading: Icon(iconData),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final String headerText;

  const ProfileHeader({Key? key, required this.headerText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            headerText,
            style: const TextStyle(
                color: Colors.grey, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 50,
                  child: Divider(
                    color: Colors.grey,
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
