import 'dart:math';

import 'package:flutter/material.dart';

class Exam extends StatefulWidget {
  const Exam({Key? key}) : super(key: key);

  @override
  _ExamState createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  Random random = Random();

  late List<Map<String, dynamic>> firstlist = [];
  late List<Map<String, dynamic>> secondlist = [];

  bool toMuchRed = false;

  @override
  void initState() {
    super.initState();
    int randomNumber = random.nextInt(10) + 5;

    late List<Map<String, dynamic>> a1 = [];
    late List<Map<String, dynamic>> a2 = [];

    for (var i = 0; i < randomNumber; i++) {
      a1.add(<String, dynamic>{'text': 'Left${i}', 'color': Colors.grey});
      a2.add(<String, dynamic>{'text': 'Right${i}', 'color': Colors.grey});
    }

    setState(() {
      firstlist = a1;
      secondlist = a2;
    });
  }

  randomMoving() {
    final allElements = [...firstlist, ...arr2];

    final allRed =
        allElements.where((item) => item['color'] == Colors.red).toList();
    final onlyRed = check(allElements, allRed);

    setState(() {
      toMuchRed = onlyRed;
    });

    if (!onlyRed) {
      int num = random.nextInt(2) + 0;

      if (firstlist.isEmpty) num = 2;

      if (secondlist.isEmpty) num = 1;

      final bool isArr1 = num == 1;
      final selectedArr = isArr1 ? firstlist : secondlist;

      int num2 = random.nextInt(selectedArr.length) + 0;

      if (isArr1) {
        if (!selectedArr[num2]['text'].contains('Right')) {
          selectedArr[num2]['color'] = Colors.red;
        } else {
          selectedArr[num2]['color'] = Colors.grey;
        }
        setState(() {
          secondlist.add(selectedArr[num2]);
          firstlist.removeAt(num2);
        });
      } else {
        setState(() {
          if (!selectedArr[num2]['text'].contains('Left')) {
            selectedArr[num2]['color'] = Colors.red;
          } else {
            selectedArr[num2]['color'] = Colors.grey;
          }

          firstlist.add(selectedArr[num2]);
          secondlist.removeAt(num2);
        });
      }
    } else {
      int num2 = random.nextInt(allRed.length) + 0;

      allRed[num2]['color'] = Colors.grey;
      if (allRed[num2]['text'].contains('Right')) {
        setState(() {
          secondlist.add(allRed[num2]);
          firstlist.removeWhere(
              (element) => element['text'] == allRed[num2]['text']);
        });
      } else {
        setState(() {
          firstlist.add(allRed[num2]);
          secondlist.removeWhere(
              (element) => element['text'] == allRed[num2]['text']);
        });
      }
    }
  }

  check(allElements, allRed) {
    return allElements.length - allRed.length < allRed.length;
  }

  @override
  Widget build(BuildContext context) {
    print(firstlist);
    print(secondlist);
    return (Scaffold(
      body: SafeArea(
          child: Container(
        child: Stack(
          children: [
            Row(
              children: <Widget>[
                ListWidget(
                  list: firstlist,
                ),
                SizedBox(
                  width: 50,
                ),
                ListWidget(
                  list: secondlist,
                )
              ],
            ),
            Positioned(
              right: 50,
              bottom: 50,
              child: FloatingActionButton(
                onPressed: () {
                  randomMoving();
                },
              ),
            ),
            if (toMuchRed)
              Positioned(
                left: 50,
                bottom: 50,
                child: FloatingActionButton(
                  onPressed: () {
                    randomMoving();
                  },
                ),
              ),
          ],
        ),
      )),
    ));
  }
}

class ListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> list;

  ListWidget({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: ListView(
        children: list.map((item) => ListItem(data: item)).toList(),
      ),
    ));
  }
}

class ListItem extends StatelessWidget {
  final Map<String, dynamic> data;

  ListItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 20,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: data['color']),
      child: Text(
        data['text'],
        style: TextStyle(color: Colors.yellow),
      ),
    );
  }
}
