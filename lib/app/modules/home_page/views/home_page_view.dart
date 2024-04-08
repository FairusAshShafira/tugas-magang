// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:magangproject/app/controllers/auth_controller.dart';
// import 'package:magangproject/app/modules/home/views/home_view.dart';
import 'package:magangproject/app/routes/app_pages.dart';

// import '../controllers/home_page_controller.dart';
class HomePageView extends StatefulWidget {
  HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final authC =  Get.find<AuthController>();
  // FirebaseUser mUser = Auth.getCurrentUser();
  // String uId = User.getUid();
  User? user = FirebaseAuth.instance.currentUser;

  late String _formattedDate = '';
  String _formattedLoginTime = "-- : --";
  String _formattedLogoutTime = "-- : --";
  late DateTime firstButtonPressTime;
  late String _formattedTime = DateFormat('HH.mm').format(DateTime.now());
  late DateTime _registrationDate;
  late int _daysSinceRegistration = 0;
  bool isLoginButtonPressed = false;
  bool isLogoutButtonPressed = false; 

  @override
  void initState() {
    super.initState();
    // Mendapatkan tanggal hari ini
    DateTime now = DateTime.now();
    // Memformat tanggal menggunakan intl package
    // ini untuk mengatur bahasa ke us
    // _formattedDate = DateFormat('dd MMMM yyyy', 'en_US').format(now); 
    _formattedDate = DateFormat('dd MMMM yyyy').format(now);

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _formattedTime = DateFormat('HH.mm').format(DateTime.now());
      });
    });

    _getRegistrationDateAndCalculateDays();
  }

  Future<void> _getUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await currentUser.reload();
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _getRegistrationDateAndCalculateDays() async {
    try {
      if (user != null) {
        // Menggunakan waktu pembuatan pengguna sebagai tanggal pendaftaran
        _registrationDate = user!.metadata.creationTime!;
        // Menghitung hari sejak pendaftaran
        _daysSinceRegistration = DateTime.now().difference(_registrationDate).inDays + 1;
        // Menghitung hari sejak pendaftaran, dengan mengurangkan 1 agar hari pertama tercatat sebagai hari pertama, bukan hari 0
        // _daysSinceRegistration = DateTime.now().difference(_registrationDate).inDays - 1;
        setState(() {});
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    'Hi!! ${user!.email}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Color.fromARGB(255, 10, 88, 156),
                        ),
                  ),
                  subtitle: Text(
                    'This is your day $_daysSinceRegistration internship here',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  trailing: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('../assets/icon.png'),
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(25),
            child: Container(
              height: 155,
              width: 400,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 67, 142, 185),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15,), 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menempatkan widget pada sisi kiri dan kanan
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5), // Spasi antara ikon dan teks
                              Text( 
                                "Hari ini, $_formattedDate",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_filled,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5), // Spasi antara ikon dan teks
                              Text( 
                                "$_formattedTime",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 25, bottom: 10), // Menambahkan padding kecuali di bagian atas
                        child: Container(
                          height: 70,
                          width: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ), // Latar belakang putih untuk padding
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 45, 109, 154), // Latar belakang putih untuk tombol
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        if (isLoginButtonPressed == false) {
                                          firstButtonPressTime = DateTime.now();
                                          String formattedButtonPressTime = DateFormat('HH:mm').format(firstButtonPressTime);
                                          print("Button first pressed at: $formattedButtonPressTime");
                                          setState(() {
                                            _formattedLoginTime = formattedButtonPressTime;
                                            isLoginButtonPressed = true;
                                          });
                                          if (isLogoutButtonPressed) {
                                            setState(() {
                                              isLogoutButtonPressed = false;
                                            });
                                          }
                                        }
                                      },
                                      icon: Icon(
                                        Icons.login,
                                        color: Colors.white, // Warna ikon biru
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(width: 5,),
                              Material( // Material untuk latar belakang putih pada teks "Presensi Masuk" beserta ikon
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                  padding: const EdgeInsets.only(top:15, left: 10,),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 10),
                                      Text(
                                        "Presensi Masuk",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 166, 166, 166),
                                          fontSize: 14,
                                        ),
                                      ),
                                      // SizedBox(height: 3,),
                                      Row(
                                        children: [
                                          Text(
                                            isLoginButtonPressed ? _formattedLoginTime : "-- : --", // Menampilkan waktu jika tombol telah ditekan, "-- : --" jika tidak
                                            style: TextStyle(
                                              color: isLoginButtonPressed ? Colors.green : Colors.grey,
                                              fontSize: 14, // Warna hijau jika tombol ditekan, abu-abu jika tidak
                                            ),
                                          ),
                                          Text(
                                            " WIB",
                                            style: TextStyle(
                                              color: isLoginButtonPressed ? Colors.green : Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 45, right: 10, bottom: 10), // Menambahkan padding kecuali di bagian atas
                        child: Container(
                          height: 70,
                          width: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ), // Latar belakang putih untuk padding
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 201, 91, 91), // Latar belakang putih untuk tombol
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        if (isLogoutButtonPressed == false) {
                                          firstButtonPressTime = DateTime.now();
                                          String formattedButtonPressTime = DateFormat('HH:mm').format(firstButtonPressTime);
                                          print("Button first pressed at: $formattedButtonPressTime");
                                          setState(() {
                                            _formattedLogoutTime = formattedButtonPressTime;
                                            isLogoutButtonPressed = true;
                                          });
                                          if (isLoginButtonPressed) {
                                            setState(() {
                                              isLoginButtonPressed = false;
                                            });
                                          }
                                        }
                                      },
                                      icon: Icon(
                                        Icons.logout,
                                        color: Colors.white, // Warna ikon biru
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(width: 5,),
                              Material( // Material untuk latar belakang putih pada teks "Presensi Masuk" beserta ikon
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                  padding: const EdgeInsets.only(top:15, left: 10,),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 15),
                                      Text(
                                        "Presensi Keluar",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 166, 166, 166),
                                          fontSize: 14,
                                        ),
                                      ),
                                      // SizedBox(height: 3,),
                                      Row(
                                        children: [
                                          Text(
                                            isLogoutButtonPressed ? _formattedLogoutTime : "-- : --", // Menampilkan waktu jika tombol telah ditekan, "-- : --" jika tidak
                                            style: TextStyle(
                                              color: isLogoutButtonPressed ? Colors.red : Colors.grey,
                                              fontSize: 14, // Warna hijau jika tombol ditekan, abu-abu jika tidak
                                            ),
                                          ),
                                          Text(
                                            " WIB",
                                            style: TextStyle(
                                              color: isLogoutButtonPressed ? Colors.red : Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5,),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "Presensi",
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //       TextButton(
          //         onPressed: () {}, 
          //         child: Text(
          //           ""
          //         ),
          //       ),
          //     ],
          //   ),
          // )

          // SizedBox(height: 25,),

          Expanded (
            child: Center (
              child: Container(
                height: 120,
                // padding: EdgeInsets.symmetric(horizontal: 15,),
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      Column (
                        children: [ 
                          Container (
                            width: 80,
                            height: 80,
                            // margin: EdgeInsets.only(left: 28,),
                            // padding: EdgeInsets.symmetric(vertical: 10,),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 67, 142, 185),
                              borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding  (
                            padding: const EdgeInsets.only(left: 0,),
                            child: Text(
                              'Presensi',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                      
                      Column (
                        children: [ 
                          Container (
                            width: 80,
                            height: 80,
                            margin: EdgeInsets.only(left: 28,),
                            // padding: EdgeInsets.symmetric(vertical: 10,),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 67, 142, 185),
                              borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding  (
                            padding: const EdgeInsets.only(left: 27,),
                            child: Text(
                              'Izin',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                      
                      Column (
                        children: [ 
                          Container (
                            width: 80,
                            height: 80,
                            margin: EdgeInsets.only(left: 28,),
                            // padding: EdgeInsets.symmetric(vertical: 10,),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 67, 142, 185),
                              borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding  (
                            padding: const EdgeInsets.only(left: 27,),
                            child: Text(
                              'Piket',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                      
                      Column (
                        children: [ 
                          Container (
                            width: 80,
                            height: 80,
                            margin: EdgeInsets.only(left: 28,),
                            padding: EdgeInsets.symmetric(vertical: 10,),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 67, 142, 185),
                              borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding  (
                            padding: const EdgeInsets.only(left: 27,),
                            child: Text(
                              'Insentif',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                      
                    ],
                  ),
                ),
            ),
          ),

          Divider(
            color: Color.fromARGB(255, 218, 218, 218), // warna garis dapat disesuaikan sesuai kebutuhan
            thickness: 1, // ketebalan garis dapat disesuaikan sesuai kebutuhan
            indent: 25, // jarak awal garis dari kiri
            endIndent: 25, // jarak akhir garis dari kanan
          ),

          Padding(
            padding: EdgeInsets.only(left: 25, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row (
                  children: [
                    Icon(
                      Icons.message,
                      color: Color.fromARGB(255, 45, 109, 154),
                    ),
                    SizedBox(width: 15,),
                    Text(
                      "Pesan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 45, 109, 154),
                      ), 
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15,),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Lihat Semua",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Color.fromARGB(255, 45, 109, 154),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 250,
            width: 400,
            child: Padding(
              padding: EdgeInsets.only(top: 15),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:  [
                  Container (
                    width: 300,
                    height: 250,
                    margin: EdgeInsets.only(left: 28, bottom: 15),
                    padding: EdgeInsets.symmetric(vertical: 10,),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 67, 142, 185),
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  Container (
                    width: 300,
                    height: 250,
                    margin: EdgeInsets.only(left: 28, bottom: 15),
                    padding: EdgeInsets.symmetric(vertical: 10,),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 67, 142, 185),
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  Container (
                    width: 300,
                    height: 250,
                    margin: EdgeInsets.only(left: 28, bottom: 15),
                    padding: EdgeInsets.symmetric(vertical: 10,),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 67, 142, 185),
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 25, top: 5,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row (
                  children: [
                    Icon(
                      Icons.timer,
                      color: Color.fromARGB(255, 45, 109, 154),
                    ),
                    SizedBox(width: 15,),
                    Text(
                      "Riwayat Presensi",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 45, 109, 154),
                      ), 
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15,),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Lihat Semua",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Color.fromARGB(255, 45, 109, 154),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child:Padding(
              padding: EdgeInsets.only(bottom: 25, top: 20),
              child: Wrap(
                direction: Axis.horizontal, // Mulai dengan tata letak horizontal
                spacing: 22, // Jarak horizontal antara kontainer
                runSpacing: 15, // Jarak vertikal antara baris kontainer
                children: [
                  Container (
                    width: 430,
                    height: 80,
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 67, 142, 185),
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  Container (
                    width: 430,
                    height: 80,
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 67, 142, 185),
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  Container (
                    width: 430,
                    height: 80,
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 67, 142, 185),
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  Container (
                    width: 430,
                    height: 80,
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 67, 142, 185),
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ],
              ),
            ),
          ),

          
        ],
      ),

      bottomNavigationBar: 
        BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 45, 109, 154),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          showSelectedLabels: true, 
          showUnselectedLabels: true,
          onTap: (index) {
            if (index == 0) {
              // Navigate to dashboard page
              Get.toNamed(Routes.HOME_PAGE);
            } else if (index == 1) {
              // Navigate to profile page
              Get.toNamed(Routes.ADMIN_PAGE);
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard,
                color: Colors.white,
              ),
              label: 'Dashboard',
              backgroundColor: Color.fromARGB(255, 26, 78, 116),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: 'Profile',
              backgroundColor: Color.fromARGB(255, 26, 78, 116),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.HOME),
        child: Icon(
          Icons.fingerprint,
          color: Colors.white,
          size: 35,
        ),
        mini: false,
        heroTag: null,
        backgroundColor: Color.fromARGB(255, 45, 109, 154),
        hoverColor: Color.fromARGB(255, 26, 78, 116),
        shape: CircleBorder(),  // Set heroTag to null to avoid conflicts
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}