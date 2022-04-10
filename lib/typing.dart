import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:typing_game/typing_controller.dart';

class MyHomePage extends StatelessWidget {
  final getController = Get.put(TypingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('タイピングゲーム'),
    );
  }

  Widget _buildBody() {
    return GetBuilder<TypingController>(
      builder: ((controller) => RawKeyboardListener(
            focusNode: controller.focusNode,
            autofocus: true,
            onKey: (event) =>
                event is RawKeyDownEvent ? controller.confirmWord(event) : null,
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: controller.finishWord.isEmpty
                          ? ''
                          : controller.setWord(controller.finishWord),
                    ),
                    TextSpan(
                      text: controller.setWord(controller.wordList),
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
