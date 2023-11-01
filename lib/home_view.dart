import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:record_life/about_us_view.dart';
import 'package:record_life/history_list_view.dart';
import 'package:record_life/util/hex_color.dart';
import 'package:record_life/util/tool.dart';
import 'package:record_life/util/tool_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

const String privacyUrl = 'https://www.google.com';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Memo',
          style: TextStyle(
            color: HexColor('#333333'),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 50),
              child: Wrap(
                runSpacing: 50,
                children: tools
                    .map(
                      (tool) => ToolButton(
                        iconPath: tool.iconPath,
                        toolTitle: tool.toolName,
                        onPressed: () => toolBtnClicked(context, tool),
                      ),
                    )
                    .toList(),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 70, right: 70, bottom: 15),
              height: 60,
              child: ElevatedButton(
                onPressed: () => profileButtonAction(context),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/icons/profile_icon.png'),
                    const Padding(padding: EdgeInsets.only(right: 10)),
                    const Text(
                      'Me',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Image.asset('assets/images/bottom_img.png'),
          ],
        ),
      ),
    );
  }

  void toolBtnClicked(BuildContext context, Tool tool) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HistoryListView(tool: tool),
      ),
    );
  }

  void profileButtonAction(BuildContext context) async {
    String? result = await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 30),
                child: Image.asset('assets/icons/logo_icon.png'),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 60),
                child: Text(
                  'Record Life',
                  style: TextStyle(
                    color: HexColor('#3FA565'),
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _itemButton(
                title: 'About Us',
                onPressed: () => Navigator.of(context).pop('aboutUs'),
              ),
              _itemButton(
                title: 'Privacy Policy',
                onPressed: () => Navigator.of(context).pop('privacy'),
              ),
            ],
          ),
        );
      },
    );

    if (result == 'aboutUs' && context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AboutUsView(),
        ),
      );
    }

    if (result == 'privacy' && await canLaunchUrlString(privacyUrl)) {
      launchUrlString(privacyUrl, mode: LaunchMode.inAppWebView);
    }
  }

  Widget _itemButton({required String title, Function()? onPressed}) {
    return Container(
      width: 175,
      height: 50,
      margin: const EdgeInsets.only(bottom: 30),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
