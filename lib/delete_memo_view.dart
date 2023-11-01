import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:record_life/util/file_manager.dart';
import 'package:record_life/util/hex_color.dart';
import 'package:record_life/util/history.dart';

class DeleteMemoView extends StatefulWidget {
  const DeleteMemoView({super.key});

  @override
  State<DeleteMemoView> createState() => _DeleteMemoViewState();
}

class _DeleteMemoViewState extends State<DeleteMemoView> {
  List<History> _histories = [];
  bool isSelectedAll = false;
  List<int> marks = [];

  @override
  void initState() {
    getHistories();
    super.initState();
  }

  void getHistories() async {
    String json = await FileManager.getContents('histories.json');
    List<dynamic> list = convert.jsonDecode(json);

    var histories = list.map((item) => History.fromJson(item)).toList();
    setState(() {
      _histories = histories;
    });
  }

  void deleteAction() {
    setState(() {
      if (isSelectedAll) {
        _histories.clear();
        isSelectedAll = false;
      } else {
        marks.sort((left, right) => right.compareTo(left));
        for (int i = 0; i < marks.length; i++) {
          _histories.removeAt(marks[i]);
        }
        marks.clear();
      }
    });
    String json = convert.jsonEncode(_histories);
    FileManager.saveFile('histories.json', json);
  }

  void markDeleteItem(int index) {
    bool isMarked = marks.contains(index);
    setState(() {
      if (isMarked) {
        marks.remove(index);
        isSelectedAll = false;
      } else {
        marks.add(index);
        if (marks.length == _histories.length) {
          isSelectedAll = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 100,
        height: 100,
        child: IconButton(
          onPressed: deleteAction,
          icon: Image.asset('assets/icons/delete_btn_icon.png'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Image.asset('assets/icons/back_icon.png'),
        ),
        title: Text(
          'Memo History',
          style: TextStyle(
            color: HexColor('#333333'),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => setState(() {
                    isSelectedAll = !isSelectedAll;
                    if (!isSelectedAll) {
                      marks.clear();
                    }
                  }),
              icon: Image.asset('assets/icons/select_all_icon.png'))
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: _histories.length,
          itemBuilder: (context, index) {
            History history = _histories[index];
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        history.title!,
                        style: TextStyle(
                          color: HexColor('#333333'),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        history.time!,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 0))
                    ],
                  ),
                  Text(
                    history.content!,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  Divider(height: 1, color: HexColor('#E9ECEA'))
                ],
              ),
              trailing: IconButton(
                onPressed: () => markDeleteItem(index),
                icon: Image.asset(
                    (isSelectedAll || marks.contains(index) == true)
                        ? 'assets/icons/check_icon_fill.png'
                        : 'assets/icons/check_icon_normal.png'),
              ),
            );
          }),
    );
  }
}
