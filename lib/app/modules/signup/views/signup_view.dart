// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:magangproject/app/controllers/auth_controller.dart';
// // import 'package:magangproject/app/routes/app_pages.dart';

// import '../controllers/signup_controller.dart';

// class SignupView extends GetView<SignupController> {
//   SignupView({Key? key}) : super(key: key);
//   final authC = Get.find<AuthController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Signup'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(25),
//         child: Column (
//           children: [
//             TextField(
//               controller: controller.emailC,
//               decoration: InputDecoration(labelText: "Email"),
//             ),
//             TextField(
//               controller: controller.passC,
//               decoration: InputDecoration(labelText: "Password"),
//             ),
//             SizedBox(height: 50,),
//             ElevatedButton(
//               onPressed: () => authC.signup(controller.emailC.text, controller.passC.text), 
//               child: Text("Register"),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Already have an account?"),
//                 TextButton(
//                   onPressed: () => Get.back(), 
//                   child: Text("Login here!"),
//                 ),
//               ], 
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magangproject/app/controllers/auth_controller.dart';
import 'package:magangproject/app/routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class SignupView extends StatefulWidget {
  SignupView({Key? key}) : super(key: key);

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final AuthController authController = Get.find<AuthController>();
  final SignupController signupController = Get.put(SignupController());

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("../assets/logo.png"),
              SizedBox(height: 20,),
              Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 243, 249, 253),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 190, 190, 190),
                      offset: const Offset(-2.0, 4.0),
                      blurRadius: 10,
                      spreadRadius: 1.5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 10, 88, 156),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 320,
                      child: TextField(
                        controller: signupController.emailC,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: const Color.fromARGB(255, 10, 88, 156),
                          ),
                          prefixIcon: Icon(
                            Icons.person_pin,
                            color: const Color.fromARGB(255, 10, 88, 156),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 320,
                      child: TextField(
                        controller: signupController.passC,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: const Color.fromARGB(255, 10, 88, 156),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: const Color.fromARGB(255, 10, 88, 156),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color.fromARGB(255, 10, 88, 156),
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                        ),
                        obscureText: obscureText,
                      ),
                    ),
                    SizedBox(height: 25),
                    GestureDetector(
                      onTap: () => authController.signup(
                        signupController.emailC.text,
                        signupController.passC.text,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: 320,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromARGB(255, 56, 113, 160),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 10, 88, 156),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed(Routes.LOGIN),
                          child: Text(
                            "Login here!",
                            style: TextStyle(
                              color: Color.fromARGB(255, 10, 88, 156),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
