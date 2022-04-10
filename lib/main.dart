import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    const TypingGame(),
  );
}

class TypingGame extends StatelessWidget {
  const TypingGame({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'タイピングゲーム',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _focusNode = FocusNode();
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
  void initState() {
    super.initState();
    setState(() {
      wordList = words[count].split('');
    });
  }

  void confirmWord(RawKeyEvent event) async {
    // keyが一致した時の処理
    if (event.logicalKey.debugName == 'Key ${wordList[zero]}') {
      setState(() {
        finishWord.add(wordList[zero]);
        wordList.removeAt(zero);
      });
    } else {
      setState(() {
        backGroundColor = Colors.red;
      });
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        backGroundColor = Colors.white;
      });
    }
    if (wordList.isEmpty) {
      finishWord.clear();
      count++;
      wordList = words[count].split('');
    }
  }

  setWord(List<String> list) {
    return list
        .map<String>(
          (String value) => value,
        )
        .join(',')
        .replaceAll(',', '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: _buildAppBar(),
      body: RawKeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKey: (event) {
          if (event is RawKeyDownEvent) confirmWord(event);
        },
        child: Center(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: finishWord.isEmpty ? '' : setWord(finishWord),
                ),
                TextSpan(
                  text: setWord(wordList),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('タイピングゲーム'),
    );
  }
}
