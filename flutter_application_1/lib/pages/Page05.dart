// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Page06.dart';
import 'EventPage.dart';

//Step 4
// ignore: must_be_immutable
class Page05 extends StatefulWidget {
  Page05(
      {Key? key, required this.title, required this.name, required this.life})
      : super(key: key);
  final String title;
  final String name;
  int life;
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names

  @override
  State<Page05> createState() => _MyHomePageState();
}

class Choice {
  final String text;

  Choice({required this.text});
}

class Dialog {
  final String char;
  final String text;
  final String imagePath;

  Dialog(this.char, this.text, this.imagePath);
}

//Step 5
class _MyHomePageState extends State<Page05> {
  List<Dialog> dialogs = [
    Dialog('', '[เลิกเรียนแล้ว]', ''),
    Dialog('', '[เธอเดินมาหาคุณ แต่คุณและเธอมีการบ้านที่ต้องทำอยู่]', ''),
  ];
  List<Dialog> dia1 = [
    Dialog('เธอ', 'ไม่เอาอะ', ''),
    Dialog('เธอ', 'เธอไปทำคนเดียวเหอะ', ''),
  ];
  List<Dialog> dia2 = [
    Dialog('เธอ', 'งั้นนั่งกันตรงนี้สักพักนะ', ''),
    Dialog('', '[คุณได้พูดคุยสารพัดกับเธอ]', ''),
  ];
  int diaCounter = 0;

  bool showChoices = false;
  bool showButtons = true;
  List<Choice> choices = [
    Choice(
      text: 'ชวนเธอทำการบ้าน',
    ),
    Choice(
      text: 'ช่างหัวการบ้าน',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: List.generate(
                  widget.life,
                  (index) => Icon(Icons.favorite, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg/F3 โรงอาหาร.JPG'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Character Picture
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 180,
                      height: 240,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(dialogs[diaCounter].imagePath),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Dialog Box
                Container(
                  width: double.infinity, // Take the full width of the screen

                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Character's Name
                      Text(
                        dialogs[diaCounter].char,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),

                      // Dialog
                      Text(
                        //Dialog[$\diaCounter].Text,
                        dialogs[diaCounter].text,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 20),

                      if (showChoices)
                        Row(
                          children: choices.map((choice) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle choice selection
                                  handleChoice(choice);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 10),
                                    Text(choice.text),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                      if (showButtons)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Handle previous button press
                                previousDialog();
                              },
                              child: Text('Previous'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle next button press
                                nextDialog();
                              },
                              child: Text('Next'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle skip button press
                                skipDialog();
                              },
                              child: Text('Skip'),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void nextDialog() {
    setState(() {
      print('Success! Clicked $diaCounter times.');
      if (diaCounter >= dialogs.length - 1) {
        // Player reached the target clicks, handle success
        print("next to end");
        enddialog();
      } else {
        diaCounter++;
      }
    });
  }

  void previousDialog() {
    setState(() {
      if (diaCounter >= 1) {
        // Player reached the target clicks, handle success
        diaCounter--;
      } else {
        enddialog();
      }
    });
  }

  void skipDialog() {
    setState(() {
      diaCounter = dialogs.length - 1;
    });
  }

  void enddialog() {
    setState(() {
      //enddialog รอบแรก
      if (dialogs.length == 2) {
        print('end dialog');
        showButtons = false;
        showChoices = true;
      }
      //
      else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Page06(
                    title: 'Chapter 5', name: widget.name, life: widget.life)));
      }
    });
  }

  void handleChoice(Choice choice) {
    setState(() {
      if (choice.text == "ชวนเธอทำการบ้าน") {
        dialogs.addAll(dia1);
        showButtons = true;
        showChoices = false;
        diaCounter = dialogs.length - 5;
        widget.life -= 1;
      } else {
        dialogs.addAll(dia2);
        showButtons = true;
        showChoices = false;
        diaCounter = dialogs.length - 6;
        widget.life += 1;
      }
    });
  }
}
