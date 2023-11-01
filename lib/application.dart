import 'package:flutter/material.dart';
import 'package:record_life/home_view.dart';
import 'package:record_life/util/hex_color.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: HexColor('#3FA565'),
        ),
      ),
      home: const HomeView(),
    );
  }
}
