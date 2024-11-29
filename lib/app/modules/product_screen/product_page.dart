import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Model for the Card data
class Item {
  String todo;
  bool completed;

  Item({required this.todo, required this.completed});
  // Factory constructor to create an Item from JSON
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      todo: json['todo'],
      completed: json['completed'],
    );
  }
}

// Controller to manage the state of the list
class ItemController extends GetxController {
  // Observable list of items
  var itemList = <Item>[].obs;

  Future<void> getData() async {
    var url = Uri.parse('https://dummyjson.com/todos?limit=10&skip=5');
    http.Response response =
        await http.get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      // Parse the JSON response
      final List<dynamic> data = json.decode(response.body)['todos'];

      // Convert each item to an Item object and update the list
      itemList.value = data.map((item) => Item.fromJson(item)).toList();
    } else {
      print('Failed to load todos');
    }
  }

  // Method to add a new item
  void addItem(Item item) {
    itemList.add(item);
  }

  // Method to remove an item by index
  void removeItem(int index) {
    itemList.removeAt(index);
  }
}

class ProductPage extends StatelessWidget {
  final ItemController itemControl = Get.put(ItemController());

  @override
  Widget build(BuildContext context) {
    itemControl.getData();
    
    return ListView.builder(
      itemCount: itemControl.itemList.length,
      itemBuilder: (context, index) {
        // Get each item from the list
        var item = itemControl.itemList[index];
        return Card(
          margin: EdgeInsets.all(8),
          color: item.completed ? Colors.green : null,
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            title: Text(item.todo, style: TextStyle(fontSize: 18)),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Remove item from the list
                itemControl.removeItem(index);
              },
            ),
          ),
        );
      },
    );
  }
}
