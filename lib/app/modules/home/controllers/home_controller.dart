import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> getData() async {
    CollectionReference products = firestore.collection("products");

    return products.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference products = firestore.collection("products");

    return products.orderBy("time", descending: true).snapshots();

    //untuk menyaring data (misal lebih dari atau kurang dari)
    // return products.where("price", isGreaterThan: "1000000").snapshots();
  }

  void deleteProduct(String docId) {
    DocumentReference docRef = firestore.collection("products").doc(docId);
    try {
      Get.defaultDialog(
        title: "Delete Data!",
        middleText: "Apakah anda yakin akan mengapus data ini?",
        onConfirm: () async {
          await docRef.delete();
          Get.back();
        },
        textConfirm: "Ya",
        textCancel: "Tidak",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan!!",
        middleText: "Tidak dapat meghapus data."
      );
    }
  }
}
