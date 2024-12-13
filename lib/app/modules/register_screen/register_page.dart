import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_intro/app/modules/register_screen/register_controller.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController rc = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: rc.setName,
            ),TextField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: rc.setEmail,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: rc.setPassword,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password Confirmation'),
              obscureText: true,
              onChanged: rc.setConfirmation,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: rc.register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
