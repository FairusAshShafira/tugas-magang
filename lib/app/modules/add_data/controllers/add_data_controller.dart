import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDataController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController priceC;  

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addProduct(String name, String price) async {
    CollectionReference products = firestore.collection("products");

    try{
      String dateNow = DateTime.now().toIso8601String();
      await products.add({
        // untuk menyaring data
        // "price": int.parse(Price),
        // lebih lanjut ada di vid tutor nomor 5 di sekitar menit ke 1.10.00 
      
        "name": name,
        "price": price,
        "time": dateNow,
      });

      Get.defaultDialog(
        title: "Berhasil!",
        middleText: "Berhasil menambahkan data.",
        onConfirm: () {
          nameC.clear();
          priceC.clear();
          Get.back(); //close dialog
          Get.back(); //back to home
        },
        textConfirm: "Oke",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
      title: "Terjadi Masalah!",
      middleText: "Tidak dapat menambahkan data.",
    );
    }
  }

  @override
  void onInit() {
    nameC = TextEditingController();
    priceC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameC.dispose();
    priceC.dispose();
    super.onClose();
  }
}