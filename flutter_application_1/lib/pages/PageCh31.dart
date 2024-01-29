// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/EventPage.dart';
import 'package:flutter_application_1/pages/Page04.dart';

//Step 4
// ignore: must_be_immutable
class Ch31 extends StatefulWidget {
  Ch31({Key? key, required this.title, required this.name, required this.life})
      : super(key: key);
  final String title;
  final String name;
  int life;

  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  var PA02;
  var PA04 = Page04(title: 'Chapter 3', name: '', life: 3);

  @override
  State<Ch31> createState() => _MyHomePageState();
}

class Choice {
  final String text;
  final String imagePath;

  Choice(this.text, this.imagePath);
}

class Dialog {
  final String char;
  final String text;
  final String imagePath;

  Dialog(this.char, this.text, this.imagePath);
}

//Step 5
class _MyHomePageState extends State<Ch31> {
  late List<Dialog> dialogs;

  @override
  void initState() {
    super.initState();
    dialogs = [
      Dialog('เธอ', 'เธอติดกิ๊บสีขาวเข้มมาด้วยเหรอ สวยจัง ฉันชอบนะ',
          'assets/character/you/You_talk.png'),
      Dialog('${widget.name}', 'จริงเหรอ ดีใจจัง', ''),
      Dialog('เธอ', 'แล้วทำไมมาสายล่ะ', 'assets/character/you/You_talk.png'),
    ];
    String Name = widget.name;
  }

  List<Dialog> dia1 = [
    Dialog('', '[คุณเข้าห้องเรียน]', ''),
    Dialog(
        '',
        '[ครูเดินเข้ามาในห้อง ส่วนคุณก็นั่งเรียนด้วยจิตใจที่ว้าวุ่นไปสักพักใหญ่]',
        ''),
    Dialog('', '[กริ๊งงงงงง]', ''),
    Dialog('', '[ได้เวลาพักเที่ยงแล้ว]', ''),
  ];
  List<Dialog> dia2 = [
    Dialog('เธอ', 'ชอบว่ากันอยู่เรื่อย เหอะ !',
        'assets/character/you/You_pissed.png'),
  ];
  int diaCounter = 0;
  bool showChoices = false;
  bool showButtons = true;

  List<Choice> choices = [
    Choice('ก็มัวแต่หากิ๊บไง', ''),
    Choice('เพราะรู้ว่าเธอจะสายมั้ง', ''),
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
              image: AssetImage('assets/bg/F2 ห้องเรียน.jpg'),
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
                                    Image.asset(
                                      choice.imagePath,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
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
      if (dialogs.length == 3) {
        showButtons = false;
        showChoices = true;
      }

      //
      else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Page04(
                    title: 'Chapter 3', name: widget.name, life: widget.life)));
      }
    });
  }

  void handleChoice(Choice choice) {
    setState(() {
      if (choice.text == "ก็มัวแต่หากิ๊บไง") {
        dialogs.add(Dialog('${widget.name}', 'ก็มัวแต่หากิ๊บไง', ''));
        dialogs.add(Dialog('เธอ', 'ฮ่า ๆ แต่ก็น่ารักดีนะ',
            'assets/character/you/You_idle.png'));
        dialogs.addAll(dia1);
        showButtons = true;
        showChoices = false;
        diaCounter = dialogs.length - 4;
      } else {
        dialogs.add(Dialog('${widget.name}', 'เพราะรู้ว่าเธอจะสายมั้ง', ''));
        dialogs.addAll(dia2);
        dialogs.addAll(dia1);
        showButtons = true;
        showChoices = false;
        diaCounter = dialogs.length - 5;

        widget.life -= 1;
      }
    });
  }
}
