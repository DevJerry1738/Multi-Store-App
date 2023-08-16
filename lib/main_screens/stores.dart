import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_Screens/visit_store.dart';
import 'package:multi_store_app/widgets/appBar_widgets.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: AppBarTitle(title: 'Stores'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('suppliers').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 120,
                      width: 120,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VisitStore(
                                        sid: snapshot.data!.docs[index]['sid'],
                                      )));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/inapp/store.jpg'),
                            Text(
                              snapshot.data!.docs[index]['storename'],
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
            return Center(
              child: Text('no stores available yet...'),
            );
          },
        ),
      ),
    );
  }
}
