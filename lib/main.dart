import 'package:flutter/material.dart';
import 'AddNewList.dart';
import 'package:want_todo/AddNewList.dart';
import 'package:want_todo/NanisuruData.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WantPage(),
    );
  }
}

class WantPage extends StatefulWidget {
  const WantPage({Key? key}) : super(key: key);

  @override
  State<WantPage> createState() => _WantPageState();
}

class _WantPageState extends State<WantPage> {
  //bottomバーをこれで管理している
  int currentPageIndex = 0;

  //データ格納用リスト
  List<NanisuruData> nanisuruList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("やりたいこと"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: nanisuruList.length,
          itemBuilder: (context, index) {
            // NanisuruData nanisuru = nanisuruList[index];
            return Slidable(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: Offset(10, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Card(
                          color: Colors.blue,
                          child: ListTile(
                            title: Text(
                              nanisuruList[index].budget.toString() +
                                  '円' +
                                  '\n' +
                                  nanisuruList[index].title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white),
                            ),
                            subtitle: Text(
                              nanisuruList[index].priorityCon +
                                  '　/　' +
                                  nanisuruList[index].easeOfUseCon,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              endActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (value) {},
                    backgroundColor: Colors.yellowAccent,
                    foregroundColor: Colors.black,
                    icon: Icons.check,
                    label: '完了',
                  ),
                  SlidableAction(
                    onPressed: (value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (index) => AddNanisuruPage()));
                    },
                    backgroundColor: Colors.lightGreenAccent,
                    foregroundColor: Colors.black,
                    icon: Icons.edit,
                    label: '編集',
                  ),
                  SlidableAction(
                    onPressed: (value) {
                      nanisuruList.remove(index);
                    },
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.black,
                    icon: Icons.delete,
                    label: '削除',
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.event_note),
            label: 'まだやれてないこと',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_rounded),
            label: 'もうやり終えたこと',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          //以下を書き換えました contextは過去描いてありませんでした。
          // final newItem = await Navigator.of(context).push(
          final List<dynamic> newItem = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNanisuruPage()),
          );
          if (newItem != null) {
            setState(() {
              nanisuruList.add(
                  NanisuruData(newItem[0], newItem[1], newItem[2], newItem[3]));
            });
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.blue,
        ),
      ),
    );
  }
}
