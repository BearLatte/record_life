import 'package:flutter/material.dart';
import 'package:record_life/util/hex_color.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Image.asset('assets/icons/back_icon.png'),
        ),
        title: Text(
          'About us',
          style: TextStyle(
            color: HexColor('#333333'),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Image.asset('assets/images/about_us_img.png'),
            const Spacer(),
            Text(
              'Version 1.0',
              style: TextStyle(
                color: HexColor('#333333'),
                fontSize: 20,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 14)),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
