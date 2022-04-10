import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:typing_game/typing.dart';

void main() {
  runApp(
    const TypingGame(),
  );
}

class TypingGame extends StatelessWidget {
  const TypingGame({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'タイピングゲーム',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => MyHomePage(),
        ),
      ],
      routingCallback: (root) {},
    );
  }
}
