import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:magangproject/app/controllers/auth_controller.dart';
import 'package:magangproject/app/routes/app_pages.dart';

// import '../controllers/home_page_admin_controller.dart';

class AdminPageView extends StatefulWidget {
  AdminPageView({Key? key}) : super(key: key);

  @override
  _AdminPageViewState createState() => _AdminPageViewState();
}

class _AdminPageViewState extends State<AdminPageView> {

  final authC =  Get.find<AuthController>();
  // FirebaseUser mUser = Auth.getCurrentUser();
  // String uId = User.getUid();
  User? user = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10), // Atur padding untuk ListTile
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Aligment dimulai dari kiri
                        children: [
                          Text(
                            'Hi!! ${user!.email}',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Color.fromARGB(255, 10, 88, 156),
                            ),
                          ),
                          SizedBox(height: 5), // Spasi antara teks nama pengguna dan label "Admin"
                          Container(
                            width: 90,
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 111, 174, 217),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              'Admin',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ClipOval(
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('../assets/icon.png'),
                          backgroundColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Column (
          //   children: [ 
          //     Container (
          //       width: 80,
          //       height: 80,
          //       // margin: EdgeInsets.only(left: 28,),
          //       // padding: EdgeInsets.symmetric(vertical: 10,),
          //       decoration: BoxDecoration(
          //         color: Color.fromARGB(255, 67, 142, 185),
          //         borderRadius: BorderRadius.circular(20)
          //       ),
          //     ),
          //     SizedBox(height: 5,),
          //     Padding  (
          //       padding: const EdgeInsets.only(left: 0,),
          //       child: Text(
          //         'Presensi',
          //         style: TextStyle(
          //           color: Colors.black,
          //           fontSize: 14,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     )
          //   ],
          // ),

          SizedBox(height: 25,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildItem('Presensi'),
                _buildItem('Izin'),
                _buildItem('Piket'),
                _buildItem('Insentif'),
              ],
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildItem('Pegawai'),
                _buildItem('Pengaturan'),
                _buildItem('Jadwal'),
                _buildItem('Pesan'),
              ],
            ),
          ),
          SizedBox(height: 25,),
          Divider(
            color: Color.fromARGB(255, 218, 218, 218), // warna garis dapat disesuaikan sesuai kebutuhan
            thickness: 1, // ketebalan garis dapat disesuaikan sesuai kebutuhan
            indent: 25, // jarak awal garis dari kiri
            endIndent: 25, // jarak akhir garis dari kanan
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
              // Navigate to users page
              Get.toNamed(Routes.HOME); //sementara
            } else {
              //navigate to profile
              Get.toNamed(Routes.ADD_DATA);
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
                Icons.groups,
                color: Colors.white,
              ),
              label: 'Profile',
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

    );
  }

  Widget _buildItem(String text) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 67, 142, 185),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}


//untuk NAVIGASI pada _buildItem

// Widget _buildItem(String text) {
//   return GestureDetector(
//     onTap: () {
      // Tambahkan logika navigasi ke halaman lain di sini
//       print('Navigasi ke halaman lain: $text');
      // Contoh: Navigasi ke halaman lain menggunakan GetX
//       if (text == 'Presensi 1') {
//         Get.toNamed(Routes.PRESENSI_1);
//       } else if (text == 'Presensi 2') {
//         Get.toNamed(Routes.PRESENSI_2);
//       }
      // Tambahkan kondisi lain sesuai kebutuhan
//     },
//     child: Column(
//       children: [
//         Container(
//           width: 80,
//           height: 80,
//           decoration: BoxDecoration(
//             color: Color.fromARGB(255, 67, 142, 185),
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//         SizedBox(height: 5),
//         Text(
//           text,
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     ),
//   );
// }


