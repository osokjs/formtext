import 'package:flutter/material.dart';
import 'package:formtext/database/database_helper.dart';
import 'package:formtext/model/group_data.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class GroupController extends GetxController {
  List<GroupData> gList = [];
  TextEditingController addGroupController = TextEditingController();

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    DatabaseHelper _dbInstance = DatabaseHelper();
    // final db = await _dbInstance.database;
    _dbInstance.queryAllGroupCode()
        .then((value) {
        gList = value;
        update();
        // print('list count: $gList.length');
        // print(gList.toString());
    });
  }

  void addData() async {
    DatabaseHelper _dbInstance = DatabaseHelper();
    // final db = await _dbInstance.database;

    try {
      await _dbInstance.insertGroupCode(addGroupController.text.trim());
      gList.add(GroupData(id: gList.length, name: addGroupController.text));
      gList.sort((a, b) => a.name.compareTo(b.name));
      addGroupController.clear();
      update();
    } catch (e) {
      throw e;
    }
  }

  void deleteTask(int id) async {
    DatabaseHelper _dbInstance = DatabaseHelper();
    // final db = await _dbInstance.database;

    await _dbInstance.deleteGroupCode(id);

    gList.removeWhere((element) => element.id == id);
    update();
  }
}
