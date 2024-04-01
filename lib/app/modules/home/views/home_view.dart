import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:magangproject/app/controllers/auth_controller.dart';
import 'package:magangproject/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final authC =  Get.find<AuthController>();
  // FirebaseUser mUser = Auth.getCurrentUser();
  // String uId = User.getUid();
  final User? user = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // FloatingActionButton to the left of the title
            // FloatingActionButton(
            //   onPressed: () => Get.toNamed(Routes.ADD_DATA),
            //   child: Icon(Icons.add),
            //   mini: true,
            //   heroTag: null,
            //   hoverColor: Colors.white,
            //   shape: CircleBorder(),  // Set heroTag to null to avoid conflicts
            // ),
            SizedBox(width: 8), // Adjust the spacing as needed
            Expanded(
              child: Center(
                child: const Text('Home'),
              ),
            ),
          ],
        ),
        centerTitle: false, // Set to false to allow manual positioning
        actions: [
          IconButton(
            onPressed: () => authC.logout(),
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      //One time get data

      // body: FutureBuilder<QuerySnapshot<Object?>> (
      //   future: controller.getData(),
      //   builder: (context, snapshot) {
      //     print(snapshot);
      //     if(snapshot.connectionState == ConnectionState.done) {
      //       var ListAllDocs = snapshot.data!.docs;
      //       return ListView.builder(
      //         itemCount: ListAllDocs.length,
      //         itemBuilder: (context, index) => ListTile(
      //           title: Text("${(ListAllDocs[index].data() as Map<String, dynamic>) ["name"]}"),
      //           subtitle: Text("Rp ${(ListAllDocs[index].data() as Map<String, dynamic>) ["price"]}"),
      //         ),
      //       );
      //     }
      //     return Center(child: CircularProgressIndicator());
      //   }
      // ),

      //real time get data

      body: Column(
        children: [
          // Syntax untuk menunjukkan data pengguna Firebase
          if (user != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                    'Hi!! ${user!.email}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
              ),

          // Syntax untuk menampilkan data Firestore menggunakan StreamBuilder
          Expanded(
            child: StreamBuilder<QuerySnapshot<Object?>>(
              stream: controller.streamData(),
              builder: (context, snapshot) {
                print(snapshot);
                if (snapshot.connectionState == ConnectionState.active) {
                  var listAllDocs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: listAllDocs.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () => Get.toNamed(
                        Routes.EDIT_DATA,
                        arguments: listAllDocs[index].id,
                      ),
                      title: Text(
                        "${(listAllDocs[index].data() as Map<String, dynamic>)["name"]}",
                      ),
                      subtitle: Text(
                        "Rp ${(listAllDocs[index].data() as Map<String, dynamic>)["price"]}",
                      ),
                      trailing: IconButton(
                        onPressed: () =>
                            controller.deleteProduct(listAllDocs[index].id),
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_DATA),
        child: Icon(Icons.add),
        mini: true,
        heroTag: null,
        hoverColor: Colors.white,
        shape: CircleBorder(),  // Set heroTag to null to avoid conflicts
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Get.toNamed(Routes.ADD_DATA),
      //   child: Icon(Icons.add),
      // ),
    );
  }
}