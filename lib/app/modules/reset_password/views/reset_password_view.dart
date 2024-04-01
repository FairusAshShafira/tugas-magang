import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:magangproject/app/controllers/auth_controller.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column (
          children: [
            TextField(
              controller: controller.emailC,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 50,),
            ElevatedButton(
              onPressed: () => authC.resetPassword(controller.emailC.text), 
              child: Text("Reset"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                  onPressed: () => Get.back(), 
                  child: Text("Login"),
                ),
              ], 
            ),
          ],
        ),
      ),
    );
  }
}
