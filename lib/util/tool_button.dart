import 'package:flutter/material.dart';
import 'package:record_life/util/hex_color.dart';
import 'package:record_life/util/tool.dart';

class ToolButton extends StatelessWidget {
  final String iconPath;
  final String toolTitle;
  final Function()? onPressed;
  const ToolButton({
    super.key,
    this.onPressed,
    required this.iconPath,
    required this.toolTitle,
  });

  @override
  Widget build(BuildContext context) {
    double toolWidth = (MediaQuery.of(context).size.width - 60) / 3;
    return SizedBox(
      width: toolWidth,
      child: TextButton(
          onPressed: onPressed,
          child: Column(
            children: <Widget>[
              Image.asset(iconPath, fit: BoxFit.cover),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              Text(
                toolTitle,
                style: TextStyle(
                  color: HexColor('#333333'),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          )),
    );
  }
}

const List<Tool> tools = [
  Tool(iconPath: 'assets/icons/birth_icon.png', toolName: 'Birthday'),
  Tool(iconPath: 'assets/icons/bill_icon.png', toolName: 'Bill'),
  Tool(iconPath: 'assets/icons/travel_icon.png', toolName: 'Travel'),
  Tool(iconPath: 'assets/icons/holiday_icon.png', toolName: 'Holiday'),
  Tool(iconPath: 'assets/icons/train_icon.png', toolName: 'Train'),
  Tool(iconPath: 'assets/icons/traffic_icon.png', toolName: 'Traffic'),
  Tool(iconPath: 'assets/icons/work_icon.png', toolName: 'Work'),
  Tool(iconPath: 'assets/icons/meeting_icon.png', toolName: 'Meeting'),
  Tool(iconPath: 'assets/icons/other_icon.png', toolName: 'Other')
];
