import 'package:flutter/material.dart';
import 'package:want_todo/NanisuruData.dart';
import 'AddNewList.dart';
import 'package:want_todo/AddNewList.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class card{
  void mainCard() {
    List<NanisuruData> nanisuruList = [];

    Center(
      child: ListView.builder(
        itemCount: nanisuruList.length,
        itemBuilder: (context, index) {
          // NanisuruData nanisuru = nanisuruList[index];
          return Slidable(
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (index) => AddNanisuruPage()));
                  },
                  backgroundColor: Colors.lightGreenAccent,
                  foregroundColor: Colors.black,
                  icon: Icons.edit,
                  label: '編集',
                ),
                SlidableAction(
                  onPressed: (value) {},
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.black,
                  icon: Icons.delete,
                  label: '削除',
                ),
              ],
            ),
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
                            nanisuruList[index].title +
                                '\n' +
                                nanisuruList[index].budget.toString() +
                                '円',
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
          );
        },
      ),
    );
  }
}
