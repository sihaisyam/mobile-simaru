import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_intro/app/modules/room_screen/room_controller.dart';

class AddRoomPage extends StatelessWidget {
  final RoomController _roomController = Get.put(RoomController());

  @override
  Widget build(BuildContext context) {
  _roomController.getCategory();

    return Scaffold(
      appBar: AppBar(title: Text('Room')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: _roomController.setName,
            ),TextField(
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: _roomController.setDescription,
            ),
            Obx(() => DropdownButton(
              hint: Text( 'Category', ),
              items: _roomController.listType.map((selectedType) {
                  return DropdownMenuItem(
                    child: new Text(
                      selectedType.name,
                    ),
                    value: selectedType.id,
                  );
                }).toList(),
              onChanged: (newValue) {
                _roomController.setCategory(newValue.toString());
              },
            )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _roomController.create,
              child: Text('Room'),
            ),
          ],
        ),
      ),
    );
  }
}
