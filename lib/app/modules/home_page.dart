import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_intro/app/data/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './product_screen/product_page.dart';
import './profile_screen/profile_page.dart';

class HomeController extends GetxController {
  var count = 0.obs;
  var profile = User().obs;
  var firstName = "".obs;
  increment() => count++;

  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //mengubah dari string ke json
    final user =
        jsonDecode(prefs.getString('user') ?? "") as Map<String, dynamic>;
    //json user di simpan didalam variable profile agar bisa di gunakan di HomePage
    profile.value = User(firstName: user['firstName'], image: user['image']);
  }
}

class BottomNavController extends GetxController {
  // Observable selected index
  var selectedIndex = 0.obs;

  // List of pages for each tab
  final List<Widget> pages = [
    OtherPage(),
    ProductPage(),
    ProfilePage(),
  ];

  // Method to handle tab selection
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(context) {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    final HomeController hc = Get.put(HomeController());
    final BottomNavController navControl = Get.put(BottomNavController());
    hc.loadUser();
    return Scaffold(
        // Use Obx(()=> to update Text() whenever count is changed.
        appBar: AppBar(
            title: Obx(
                () => Text("Selamat Datang ${hc.profile.value.firstName}"))),
        // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
        body: Obx(() {
          // Use the selectedIndex to show the corresponding page
          return navControl.pages[navControl.selectedIndex.value];
        }),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBar(
            currentIndex: navControl.selectedIndex.value,
            onTap: navControl.onItemTapped,
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
                icon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
          );
        }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: hc.increment));
  }
}

class OtherPage extends StatelessWidget {
  // You can ask Get to find a Controller that is being used by anPage page and redirect you to it.
  final HomeController hc = Get.find();

  @override
  Widget build(context) {
    // Access the updated count variable
    return Scaffold(body: Center(child: Text("${hc.count}")));
  }
}
