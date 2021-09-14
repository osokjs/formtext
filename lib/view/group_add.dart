import 'package:flutter/material.dart';
import 'package:formtext/controller/group_controller.data.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class GroupManage extends StatefulWidget {
  const GroupManage({Key? key}) : super(key: key);

  @override
  _GroupManageState createState() => _GroupManageState();
}

class _GroupManageState extends State<GroupManage> {
  final GroupController groupController = Get.put(GroupController());
  AudioPlayer _player = AudioPlayer();

  //TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _player = AudioPlayer();
    }

    @override
  void dispose() {
    //_controller.dispose();
    groupController.addGroupController.dispose();
    _player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groupController = Get.put(GroupController());

    return Scaffold(
      appBar: AppBar(
        title: Text('그룹 관리'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: groupController.addGroupController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '그룹명:',
                      //helperText: '그룹명을 등록하는 절차입니다.',
                      hintText: '그룹명을 10자 이내로 입력하세요.',
                    ),
                    autofocus: true,
                  ), // TextField
                ), // Expanded
                SizedBox(
                  width: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      //String value = _controller.text;
                      String value =
                          groupController.addGroupController.text.trim();

                      if (!_isValid(context, value)) return;

                      print('text value($value)');
                      // Get.defaultDialog(
                      //   title:'Get.defaultDialog 알림창',
                      //   middleText: '입력값: $value, 길이: ${value.length}',
                      //   textConfirm: '확인',
                      //   textCancel: '취소',
                      // );
                      try {
                        groupController.addData();
                      } catch (e) {
                        print(e.toString());
                      }
                      // _showAlertDialog(context, value);
                      //_controller.text = '';
                      //setState(() {});
                    },
                    child: Text('그룹 등록'),
                  ), // ElevatedButton
                ), // Container
              ],
            ), // Row
            SizedBox(
              height: 20,
            ),
            buildGroupList(context),
          ],
        ), // Column
      ), // GestureDetector
    ); // Scaffold
  } // build

  Widget buildGroupList(BuildContext context) {
    return Expanded(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: OutlinedButton(
              child: Text('조회하기'),
              onPressed: () async {
try {
  print('before set assets');
   await _player.setAsset('assets/audio/cow.mp3');
  // final url =
  // 'https://www.applesaucekids.com/sound%20effects/moo.mp3';
  // await _player.setUrl(url);

  print('before play');
  _player.play();
  // print('------before set assets url');
  // final url =
  // 'https://www.applesaucekids.com/sound%20effects/horse.mp3';
  // await _player.setUrl(url);
  //
  // print('------before play');
  // _player.play();
} catch(e) {
  print('에러 발생: ${e.toString()}');
}

                groupController.getData();
              },
            ), // OutlinedButton
          ), // Center
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: GetBuilder<GroupController>(
              builder: (_dx) => ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _dx.gList.length,
                itemBuilder: (context, index) {
                  return Text(
                    '${_dx.gList[index].name}, id = $index',
                  );
                },
              ), // ListView.builder
            ), // GetBuilder
          ), // Expanded
        ],
      ), // Column
    ); // Expanded
  } // buildGroupList

  bool _isValid(BuildContext context, String value) {
    String errorMessage = '정상';

    if (value == null) {
      errorMessage = '그룹명을 입력하세요.';
      print(errorMessage);
      _showAlertDialog(context, errorMessage);
      return false;
    }

    String val = value.trim();

    if (val.length < 1) {
      errorMessage = '구룹명은 반드시 입력해야 합니다.';
      print(errorMessage);
      _showAlertDialog(context, errorMessage);
      return false;
    } else if (val.length > 10) {
      errorMessage = '구룹명은 한글 기준 최대 10자까지만 입력 가능합니다.';
      print(errorMessage);
      _showAlertDialog(context, errorMessage);
      return false;
    }
    return true;
  } // _isValid

  void _showAlertDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: Text('알림창 다이알로그'),
          content: Text('내용: $content, 길이: ${content.length}'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, "OK");
              },
            ),
          ],
        );
      },
    );
  } // _showAlertDialog

} // class
