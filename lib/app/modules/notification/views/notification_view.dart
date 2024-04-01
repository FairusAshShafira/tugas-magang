import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  NotificationView({Key? key}) : super(key: key);

  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotificationView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            user != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Verifikasi Email Dikirimkan!",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 56, 113, 160),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Kami telah mengirimkan email verifikasi ke alamat email",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          // Tambahkan logika yang ingin dilakukan ketika container ditekan
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 90, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color.fromARGB(255, 224, 224, 224),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "${user.email}",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 56, 113, 160),
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextButton(
                        onPressed: () async {
                          final currentUser = FirebaseAuth.instance.currentUser;
                          if (currentUser != null) {
                            try {
                              await currentUser.sendEmailVerification();
                              Get.snackbar(
                                "Pengiriman Ulang Verifikasi",
                                "Email verifikasi telah dikirim ulang.",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            } catch (e) {
                              print("Gagal mengirim ulang verifikasi: $e");
                              // Handle error, for example:
                              Get.snackbar(
                                "Gagal",
                                "Gagal mengirim ulang verifikasi. Silakan coba lagi nanti.",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          } else {
                            print("Tidak ada pengguna yang terautentikasi");
                            // Handle case when there is no authenticated user, for example:
                            Get.snackbar(
                              "Tidak Ada Pengguna",
                              "Silakan login terlebih dahulu untuk mengirim ulang verifikasi.",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        child: Text(
                          "Kirim Ulang Verifikasi",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 10, 88, 156),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          "Silahkan periksa kotak masuk Anda dan ikuti langkah-langkah verifikasi untuk menyelesaikan proses pendaftaran. Klik login jika anda telah melakukan verifikasi.",
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                : CircularProgressIndicator(),
            SizedBox(height: 20),
            InkWell(
              onTap: () => Get.toNamed('/login'),
              child: Container(
                alignment: Alignment.center,
                width: 220,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(255, 56, 113, 160),
                ),
                child: Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
