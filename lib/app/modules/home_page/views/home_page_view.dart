import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:magangproject/app/controllers/auth_controller.dart';
import 'package:magangproject/app/modules/home/views/home_view.dart';
import 'package:magangproject/app/routes/app_pages.dart';

import '../controllers/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  HomePageView({Key? key}) : super(key: key);
  int _currentIndex = 1;
  final authC =  Get.find<AuthController>();
  // FirebaseUser mUser = Auth.getCurrentUser();
  // String uId = User.getUid();
  final User? user = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
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
                    'This is your day 75 internship here',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  trailing: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/Logo.png'),
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 45, 109, 154),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        showSelectedLabels: true,       // Tampilkan label pada item terpilih
        showUnselectedLabels: true,
        onTap: (index) {
          if (index == 0) {
            // Navigate to dashboard page
            Get.toNamed(Routes.HOME_PAGE);
          } else if (index == 1) {
            // Navigate to profile page
            Get.toNamed(Routes.HOME);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
            label: 'Dashboard',
            backgroundColor: Color.fromARGB(255, 45, 109, 154),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: 'Profile',
            backgroundColor: Color.fromARGB(255, 45, 109, 154),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_DATA),
        child: Icon(
          Icons.fingerprint,
          color: Colors.white,
        ),
        mini: true,
        heroTag: null,
        backgroundColor: Color.fromARGB(255, 45, 109, 154),
        hoverColor: Color.fromARGB(255, 26, 78, 116),
        shape: CircleBorder(),  // Set heroTag to null to avoid conflicts
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
