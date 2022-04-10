import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TypingController extends GetxController {
  final focusNode = FocusNode();
  // セットした単語をリスト化
  late List<String> wordList;
  List<String> finishWord = [];
  // セットするワードの位置
  int count = 0;
  // ワードの長さ
  int zero = 0;
  // ダミーデータ
  List<String> words = ['BANANA', 'APPLE', 'BANANA', 'ORANGE'];
  Color backGroundColor = Colors.white;

  @override
  void onInit() {
    super.onInit();
    wordList = words[count].split('');
    update();
  }

  void confirmWord(RawKeyEvent event) async {
    // keyが一致した時の処理
    if (event.logicalKey.debugName == 'Key ${wordList[zero]}') {
      finishWord.add(wordList[zero]);
      wordList.removeAt(zero);
    } else {
      backGroundColor = Colors.red;
      await Future.delayed(const Duration(milliseconds: 100));
      backGroundColor = Colors.white;
    }
    if (wordList.isEmpty) {
      finishWord.clear();
      count++;
      wordList = words[count].split('');
    }
    update();
  }

  setWord(List<String> list) {
    return list
        .map<String>(
          (String value) => value,
        )
        .join(',')
        .replaceAll(',', '');
  }
}
