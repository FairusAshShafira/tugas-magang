import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class QueryController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void filter(int age) async {
    final results = await firestore
      .collection("user")
      .orderBy("name")
      .startAt(["Dion"]).get(); // jumlah tergantung nama

      //penjelasan lebih lanjut terdapat pada menit ke 23 di video ke 6

    if(results.docs.length > 0) {
      print("Total data filter : ${results.docs.length}");
      results.docs.forEach((element) {
        var id = element.id;
        var data = element.data();

        print("ID : $id");
        print("DATA : $data");
      });
    } else {
      print("Data tidak ditemukan");
    }
  }

}
