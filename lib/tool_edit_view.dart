import 'dart:convert' as convert;

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:record_life/util/file_manager.dart';
import 'package:record_life/util/hex_color.dart';
import 'package:record_life/util/hidden_keyboard_wraper.dart';
import 'package:record_life/util/history.dart';
import 'package:record_life/util/tool.dart';

class ToolEditView extends StatefulWidget {
  final Tool tool;
  final List<History> histories;
  const ToolEditView({
    super.key,
    required this.tool,
    required this.histories,
  });

  @override
  State<ToolEditView> createState() => _ToolEditViewState();
}

class _ToolEditViewState extends State<ToolEditView> {
  final _textEditController = TextEditingController();
  late List<History> _histories;

  @override
  void initState() {
    _histories = widget.histories;
    super.initState();
  }

  @override
  void dispose() {
    _textEditController.dispose();
    super.dispose();
  }

  void addMemoAction() async {
    if (_textEditController.text.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: 'Memo content cannot be empty!',
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    // DateTime.now();
    History his = History(
      title: widget.tool.toolName,
      content: _textEditController.text,
      time: formatDate(
        DateTime.now(),
        [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss],
      ),
    );

    _histories.add(his);
    var json = convert.jsonEncode(_histories);
    await FileManager.saveFile('histories.json', json);
    if (context.mounted) {
      Navigator.of(context).pop('successed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return HiddenKeyboardWrapper(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          width: 100,
          height: 100,
          child: ElevatedButton(
            onPressed: addMemoAction,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(HexColor("#3FA565")),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Image.asset('assets/icons/back_icon.png'),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            widget.tool.toolName,
            style: TextStyle(
              color: HexColor('#333333'),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
          children: [
            Image.asset(widget.tool.iconPath, height: 40),
            TextField(
              controller: _textEditController,
              maxLines: null,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Please enter memo',
                hintStyle: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
