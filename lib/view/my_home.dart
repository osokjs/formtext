import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'group_add.dart';

class MyAppHome extends StatelessWidget {
  const MyAppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextButton(
                onPressed: () => Get.toNamed('/group_add'),
                child: Text(
                  '그룹 관리',
                ),
            ), // TextButton
            SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () => Get.toNamed('/group_list'),
              child: Text(
                '그룹 리스트',
              ),
            ), // TextButton
          ],
        ), // Column
      ),// padding
    );
  }
}
