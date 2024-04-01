// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:magangproject/app/routes/app_pages.dart';

// class AuthController extends GetxController {
//   FirebaseAuth auth = FirebaseAuth.instance;

//   // Stream<User?> streamAuthStatus() {
//   //   return auth.authStateChanges();
//   // }
//   // bisa pakai yang di atas atau yang dibawah.
//   Stream<User?> get streamAuthStatus => auth.authStateChanges(); 

//   void resetPassword (String email) async {
//     if(email != "" && GetUtils.isEmail(email)) {
//       try{
//         await auth.sendPasswordResetEmail(email: email);
//         Get.defaultDialog(
//           title: "Reset berhasil!",
//           middleText: "Kami telah mengirimkan reset password ke email $email.",
//           onConfirm: () {
//             Get.back(); //close dialog
//             Get.back(); //back to login
//           },
//           textConfirm: "Ya, saya mengerti",
//         );
//       } catch (e) {
//         Get.defaultDialog(
//           title: "Terjadi Kesalahan",
//           middleText: "Tidak dapat mengirimkan reset password",
//         );
//       }
//     } else {
//       Get.defaultDialog(
//         title: "Terjadi Kesalahan",
//         middleText: "Email tidak valid",
//       );
//     }
//   }

//   void login(String email, String password) async {
//     try {
//         UserCredential myUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: email, 
//           password: password,
//         );
//         // if(myUser.user!.emailVerified) {
//           Get.offAllNamed(Routes.HOME);
//         // } else{
//         //   Get.defaultDialog(
//         //     title: "Verification Email",
//         //     middleText: "Anda perlu melakukan verifikasi email terlebih dahulu. Apakah anda ingin kami mengirimkan verifikasi ulang?",
//         //     onConfirm:  () async {
//         //       await myUser.user!.sendEmailVerification();
//         //       Get.back();
//         //     },
//         //     textConfirm: "Kirim Ulang",
//         //     textCancel: "Kembali", 
//         //   );
        
//     } on FirebaseAuthException catch (e) {
//       print(e.code);
//       print(e.message);
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//         Get.defaultDialog(
//           title: "Terjadi Kesalahan!!",
//           middleText: "No user found for that email.",
//         );
//       } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user.');
//         Get.defaultDialog(
//           title: "Terjadi Kesalahan!!",
//           middleText: "Wrong password provided for that user.",
//         );
//       } else {
//         Get.defaultDialog(
//           title: "Terjadi Kesalahan!!",
//           middleText: "Mungkin email atau password anda salah.",
//         );
//       }
//     } catch(e) {
//       Get.defaultDialog(
//           title: "Terjadi Kesalahan!!",
//           middleText: "Tidak dapat login dengan akun ini.",
//         );
//     }
//   }

//   void signup(String email, String password) async {
//   try {
//     UserCredential myUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

//     try {
//       await myUser.user!.sendEmailVerification();
//       // Get.offNamed('/notification');
//       Get.defaultDialog(
//         title: "Verification Email",
//         middleText: "Kami telah mengirimkan email verifikasi pada akun $email.",
//         onConfirm: () {
//           Get.back(); //close dialog
//           Get.back(); //go to login
//         },
//         textConfirm: "Saya akan melihat email"
//       );
//     } catch (e) {
//       print(e);
//       Get.defaultDialog(
//         title: "Terjadi Kesalahan!!",
//         middleText: "Tidak dapat mengirimkan email verifikasi. Silakan coba lagi nanti.",
//       );
//     }
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       print('The password provided is too weak.');
//       Get.defaultDialog(
//         title: "Terjadi Kesalahan!!",
//         middleText: "The password provided is too weak.",
//       );
//     } else if (e.code == 'email-already-in-use') {
//       print('The account already exists for that email.');
//       Get.defaultDialog(
//         title: "Terjadi Kesalahan!!",
//         middleText: "The account already exists for that email.",
//       );
//     } else {
//       print(e);
//       Get.defaultDialog(
//         title: "Terjadi Kesalahan!!",
//         middleText: "Periksa kembali apakah akun anda sudah benar.",
//       );
//     }
//   } catch (e) {
//     print(e);
//     Get.defaultDialog(
//       title: "Terjadi Kesalahan!!",
//       middleText: "Tidak dapat mendaftarkan akun ini. Silakan coba lagi nanti.",
//     );
//   }
// }


//   void logout() async {
//     await FirebaseAuth.instance.signOut();
//     Get.offAllNamed(Routes.LOGIN);
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:magangproject/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void resetPassword(String email) async {
    if (email.isNotEmpty && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
          title: "Reset berhasil!",
          middleText: "Kami telah mengirimkan reset password ke email $email.",
          onConfirm: () {
            Get.back(); //close dialog
            Get.back(); //back to login
          },
          textConfirm: "Ya, saya mengerti",
        );
      } catch (e) {
        print(e);
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat mengirimkan reset password",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Email tidak valid",
      );
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential? myUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (myUser.user!.emailVerified) {
        Get.offAllNamed(Routes.HOME_PAGE);
      } else {
        Get.defaultDialog(
          title: "Verification Email",
          middleText: "Anda perlu melakukan verifikasi email terlebih dahulu. Apakah anda ingin kami mengirimkan verifikasi ulang?",
          onConfirm: () async {
            await myUser.user!.sendEmailVerification();
            Get.back();
          },
          textConfirm: "Kirim Ulang",
          textCancel: "Kembali",
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.defaultDialog(
          title: "Terjadi Kesalahan!!",
          middleText: "No user found for that email.",
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.defaultDialog(
          title: "Terjadi Kesalahan!!",
          middleText: "Wrong password provided for that user.",
        );
      } else {
        Get.defaultDialog(
          title: "Terjadi Kesalahan!!",
          middleText: "Mungkin email atau password anda salah.",
        );
      }
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan!!",
        middleText: "Tidak dapat login dengan akun ini.",
      );
    }
  }

  void signup(String email, String password) async {
    try {
      UserCredential? myUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      try {
        await myUser.user!.sendEmailVerification();
              Get.offNamed('/notification');

        // Get.defaultDialog(
        //   title: "Verification Email",
        //   middleText: "Kami telah mengirimkan email verifikasi pada akun $email.",
        //   onConfirm: () {
        //     Get.back(); //close dialog
        //     Get.back(); //go to login
        //   },
        //   textConfirm: "Saya akan melihat email",
        // );
      } catch (e) {
        print(e);
        Get.defaultDialog(
          title: "Terjadi Kesalahan!!",
          middleText: "Tidak dapat mengirimkan email verifikasi. Silakan coba lagi nanti.",
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Get.defaultDialog(
          title: "Terjadi Kesalahan!!",
          middleText: "The password provided is too weak.",
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.defaultDialog(
          title: "Terjadi Kesalahan!!",
          middleText: "The account already exists for that email.",
        );
      } else {
        print(e);
        Get.defaultDialog(
          title: "Terjadi Kesalahan!!",
          middleText: "Periksa kembali apakah akun anda sudah benar.",
        );
      }
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan!!",
        middleText: "Tidak dapat mendaftarkan akun ini. Silakan coba lagi nanti.",
      );
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
