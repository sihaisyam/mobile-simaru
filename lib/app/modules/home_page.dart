import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_intro/app/data/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var count = 0.obs;
  var profile = User().obs;
  var firstName = "".obs;
  increment() => count++;

  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = jsonDecode(prefs.getString('user') ?? "") as Map<User, dynamic>;
    profile.value = user as User;
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(context) {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    final HomeController hc = Get.put(HomeController());
    hc.loadUser();
    return Scaffold(
        // Use Obx(()=> to update Text() whenever count is changed.
        appBar: AppBar(title: Obx(() => Text("Selamat Datang ${hc.profile.value.firstName}"))),
        // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
        body: Center(
            child: ElevatedButton(
                child: Text("Go to Other"), onPressed: () => Get.to(Other()))),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.amber[800],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: hc.increment));
  }
}

class Other extends StatelessWidget {
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  final HomeController hc = Get.find();

  @override
  Widget build(context) {
    // Access the updated count variable
    return Scaffold(body: Center(child: Text("${hc.count}")));
  }
}
