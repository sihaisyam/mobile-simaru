import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_intro/app/modules/room_screen/add_room_page.dart';
import 'package:getx_intro/app/modules/room_screen/room_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoomPage extends StatelessWidget {
  final RoomController roomController = Get.put(RoomController());

  @override
  Widget build(BuildContext context) {
    roomController.getData();
    
    return ListView.builder(
      itemCount: roomController.RoomList.length,
      itemBuilder: (context, index) {
        // Get each Room from the list
        var item = roomController.RoomList[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            title: Text(item.name, style: TextStyle(fontSize: 18)),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // Remove Room from the list
                Get.to(AddRoomPage());
              },
            ),
          ),
        );
      },
    );
  }
}
