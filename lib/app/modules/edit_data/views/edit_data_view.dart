import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_data_controller.dart';

class EditDataView extends GetView<EditDataController> {
  const EditDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getData(Get.arguments), 
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.nameC.text = data["name"];
            controller.priceC.text = data["price"];
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column (
                children: [
                  TextField(
                    controller: controller.nameC,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Product Name",
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: controller.priceC,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: "Price",
                    ),
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed: () => controller.editProduct(
                      controller.nameC.text, 
                      controller.priceC.text,
                      Get.arguments,
                    ), 
                    child: Text("EDIT PRODUCT"),
                    ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}
