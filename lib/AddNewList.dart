import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:want_todo/calendar.dart';


class AddNanisuruPage extends StatefulWidget {
  @override
  _AddNanisuruState createState() => _AddNanisuruState();
}

class _AddNanisuruState extends State<AddNanisuruPage> {
  TextEditingController priorityCon = TextEditingController();
  final TextEditingController easeOfUseCon = TextEditingController();
  int budget = 0;
  String title = '';
  DateTime date = DateTime.now();
  // DateFormat outputFormat = DateFormat.yMd();
  var _labelText = ('日付を記録する');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      locale: const Locale("ja"),
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
    );
    if (selected != null) {
      setState(() {
        _labelText = DateFormat.MMMEd('ja').format(selected);
        // date = _labelText;
        print('japanese→' + _labelText);
        print(date);
        //_labelTextのほうがユーザに表示される。dateは裏でカレンダーに予定を追加するための変数
      });
    }
  }

  TextFormField buildTextFormFieldPriority(BuildContext context) {
    return TextFormField(
      onTap: () {
        // キーボードが出ないようにする
        FocusScope.of(context).requestFocus(new FocusNode());
        showPickerPriority();
      },
      controller: priorityCon,
      decoration: const InputDecoration(hintText: '記録する'),
    );
  }

  TextFormField buildTextFormFieldEaseOfUse(BuildContext context) {
    return TextFormField(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        showPickerEaseOfUse();
      },
      controller: easeOfUseCon,
      decoration: const InputDecoration(hintText: '記録する'),
    );
  }

  final priority_list = [
    'いつかやってみたい',
    'ちょっとだけ気になる',
    'そこそこ気になる',
    'やってみたい',
    '超やってみたい',
  ];

  final ease_of_use_list = [
    '超お手軽',
    'そこそこお手軽',
    'まぁ普通',
    'ちょっと贅沢',
    'ラグジュアリー',
  ];

  void showPickerPriority() {
    var list = priority_list;

    final _pickerItems = list.map((item) => Text(item)).toList();
    var selectedIndex = 0;

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 216,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CupertinoPicker(
              itemExtent: 32,
              children: _pickerItems,
              onSelectedItemChanged: (int index) {
                selectedIndex = index;
              },
            ),
          ),
        );
      },
    ).then((_) {
      priorityCon.value = TextEditingValue(text: list[selectedIndex]);
    });
  }

  void showPickerEaseOfUse() {
    var list = ease_of_use_list;

    final _pickerItems = list.map((item) => Text(item)).toList();
    var selectedIndex = 0;

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 216,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CupertinoPicker(
              itemExtent: 32,
              children: _pickerItems,
              onSelectedItemChanged: (int index) {
                selectedIndex = index;
              },
            ),
          ),
        );
      },
    ).then((_) {
      easeOfUseCon.value = TextEditingValue(text: list[selectedIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'welcome to the world',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ナニスルを作成'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'タイトルを入力してください',
                  ),
                  maxLines: 1,
                  onChanged: (String inputTitle) {
                    title = inputTitle;
                  },
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  children: [
                    const Text(
                      "予定日",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_labelText),
                        IconButton(
                          icon: Icon(Icons.date_range),
                          onPressed: () => _selectDate(context),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  children: [
                    const Text(
                      "予算",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    TextField(
                      decoration: const InputDecoration(hintText: '記録する'),
                      keyboardType: TextInputType.number,
                      onChanged: (String budgetString) {
                        budget = int.parse(budgetString);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  children: [
                    const Text(
                      "やりたいレベル",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    buildTextFormFieldPriority(context),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  children: [
                    const Text(
                      "手軽さ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    buildTextFormFieldEaseOfUse(context),
                  ],
                ),
              ),


              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('戻る'),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            List<dynamic> newItem = [
              title,
              priorityCon.text,
              easeOfUseCon.text,
              budget,
              date,
            ];

            if (title != '') {
              Navigator.of(context).pop(newItem);
            } else {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    '未入力の項目があります',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  content: const Text(
                    '実はタイトルだけでも登録できます。その場合予算は¥0になってしまいますが…',
                    style: TextStyle(
                      fontSize: 12.5,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context)
                          .popUntil((route) => route.isFirst),
                      child: const Text(
                        '破棄',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text(
                        '書き直す',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            ;
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
