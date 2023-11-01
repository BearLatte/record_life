import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:record_life/delete_memo_view.dart';
import 'package:record_life/tool_edit_view.dart';
import 'package:record_life/util/file_manager.dart';
import 'package:record_life/util/hex_color.dart';
import 'package:record_life/util/history.dart';
import 'package:record_life/util/tool.dart';

class HistoryListView extends StatefulWidget {
  final Tool tool;
  const HistoryListView({super.key, required this.tool});

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  List<History> _histories = [];

  @override
  void initState() {
    super.initState();
    getMemories();
  }

  void getMemories() async {
    String json = await FileManager.getContents('histories.json');
    List<dynamic> list = convert.jsonDecode(json);

    var histories = list.map((item) => History.fromJson(item)).toList();
    setState(() {
      _histories = histories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: _histories.isNotEmpty
              ? fullListContentView()
              : emptyContentView()),
      backgroundColor: Colors.white,
    );
  }

  Widget fullListContentView() {
    return Stack(
      children: [
        ListView(
          children: [
            ..._histories.map(
              (history) => ListTile(
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
                          style: const TextStyle(
                              color: Colors.black, fontSize: 13),
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
              ),
            ),
          ],
        ),
        Positioned(left: 0, right: 0, bottom: 0, child: bottomBar())
      ],
    );
  }

  Widget emptyContentView() {
    return Column(
      children: [
        const Spacer(),
        Text(
          'Come and record it',
          style: TextStyle(
            color: HexColor('#333333'),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Image.asset('assets/images/list_empty_img.png'),
        const Spacer(),
        bottomBar()
      ],
    );
  }

  Widget bottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: _histories.isEmpty
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 100,
            height: 100,
            child: IconButton(
              onPressed: addMemoAction,
              icon: Image.asset('assets/icons/add_btn_icon.png'),
            ),
          ),
          if (_histories.isNotEmpty)
            SizedBox(
              width: 100,
              height: 100,
              child: IconButton(
                onPressed: deleteMemoAction,
                icon: Image.asset('assets/icons/delete_btn_icon.png'),
              ),
            ),
        ],
      ),
    );
  }

  void addMemoAction() async {
    debugPrint('DEBUG: 添加');
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            ToolEditView(tool: widget.tool, histories: _histories),
      ),
    );
    if (result != null) getMemories();
  }

  void deleteMemoAction() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const DeleteMemoView()))
        .then((_) => getMemories());
  }
}
