import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// Model for the Card data
class Room {
  String name;
  String description;
  Object category;

  Room({
    required this.name, 
    required this.description, 
    required this.category
  });
  // Factory constructor to create an Room from JSON
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['name'],
      description: json['description'],
      category: json['category'],
    );
  }
}
// Controller to manage the state of the list
class RoomController extends GetxController {
  // Observable list of Rooms
  
  var RoomList = <Room>[].obs;
  var listType = [].obs;

  var name = ''.obs;
  var description = ''.obs;
  var categoryId = ''.obs;

  void setName(String value) => name.value = value;
  void setDescription(String value) => description.value = value;
  void setCategory(String value) => categoryId.value = value;

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //mengubah dari string ke json
    final user = jsonDecode(prefs.getString('user') ?? "") as Map<String, dynamic>;
    var token = user['accessToken'];

    var url = Uri.parse('https://simaru.amisbudi.cloud/api/rooms');
    http.Response response =
        await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer '+ token,
          });
    if (response.statusCode == 200) {
      // Parse the JSON response
      final List<dynamic> data = json.decode(response.body)['data'];
      // Convert each Room to an Room object and update the list
      RoomList.value = data.map((room) => Room.fromJson(room)).toList();
    } else {
      print('Failed to load todos');
    }
  }

  Future<void> getCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //mengubah dari string ke json
    final user = jsonDecode(prefs.getString('user') ?? "") as Map<String, dynamic>;
    var token = user['accessToken'];

    var url = Uri.parse('https://simaru.amisbudi.cloud/api/categories');
    http.Response response =
        await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer '+ token,
          });
    if (response.statusCode == 200) {
      // Parse the JSON response
      final List<dynamic> data = json.decode(response.body);
      // Convert each Room to an Room object and update the list
      listType.value = data.toList();
    } else {
      print('Failed to load todos');
    }
  }

  Future<void> create() async {
    var url = Uri.parse('https://simaru.amisbudi.cloud/api/rooms');
    http.Response response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name.value,
          'description': description.value,
          'categoryId': categoryId.value,
        }));
    if (response.statusCode == 201) {
      Get.snackbar('Success', "Add berhasil!");
      Get.back(); // Replace with your next page
    } else {
      Get.snackbar('Error', response.body);
    }
  }

  // Method to add a new Room
  void addRoom(Room Room) {
    RoomList.add(Room);
  }

  // Method to remove an Room by index
  void removeRoom(int index) {
    RoomList.removeAt(index);
  }
}