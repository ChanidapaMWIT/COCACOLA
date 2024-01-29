// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/EventPage.dart';
import 'package:flutter_application_1/pages/Page04.dart';
import 'package:flutter_application_1/pages/PageCh32.dart';

//Step 4
// ignore: must_be_immutable
class Page03 extends StatefulWidget {
  Page03(
      {Key? key, required this.title, required this.name, required this.life})
      : super(key: key);
  final String title;
  final String name;
  final int life;

  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  var PA02;

  @override
  State<Page03> createState() => _MyHomePageState();
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
class _MyHomePageState extends State<Page03> {
  List<Dialog> dialogs = [
    Dialog('', '[คุณเดินไปที่ลิ้นชักเก็บของ]', ''),
    Dialog('', '[เลือกสีกิ๊บที่จะติดไปทำให้เธอประทับใจ]', ''),
  ];
  List<Dialog> dia1 = [
    Dialog('', '[คุณหากิ๊บสีขาวเข้มอยู่นานมากกกกก]', 'assets/item/ขาวเข้ม.PNG'),
    Dialog('', '[ในที่สุดก็เจอ !]', ''),
    Dialog('', '[ได้เวลาไปโรงเรียน แต่...เอ๊ะ !]', ''),
    Dialog(
        '',
        '[ขณะนี้เป็นเวลา 7:58 น. และบ้านของคุณอยู่ห่างจากโรงเรียน 500 เมตร]',
        ''),
    Dialog('', '[เตรียมวิ่งให้ดีล่ะ !]', ''),
  ];
  List<Dialog> dia2 = [
    Dialog('', '[คุณออกจากบ้านเพื่อไปเรียน]', ''),
  ];
  int diaCounter = 0;

  bool showChoices = false;
  bool showButtons = true;

  List<Choice> choices = [
    Choice('ขาวเข้ม', 'assets/item/ขาวเข้ม.PNG'),
    Choice('เขียวเปียก', 'assets/item/เขียวเปียก.PNG'),
    Choice('ชมพูฟริ้ง', 'assets/item/ชมพูฟริ้ง.PNG'),
    Choice('ดำอ่อน', 'assets/item/ดำอ่อน.PNG'),
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
              image: AssetImage('assets/bg/F1 ห้องนอน.JPG'),
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
                        Column(
                          children: choices.map((choice) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle choice selection
                                  handleChoice(choice);
                                },
                                child: Column(
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
      print(dialogs.length);
      //เข้า enddialog รอบแรก
      if (dialogs.length == 2) {
        print('end dialog');
        showButtons = false;
        showChoices = true;
      }
      //ตอบสีขาวเข้ม เพิ่ม dialog ต่อ
      if (dialogs.length == 7) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventPage(
                    clickerGame: ClickerGame(),
                    name: widget.name,
                    life: widget.life)));
      }
      //ตอบสีอื่น ไม่สาย
      if (dialogs.length == 3) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Ch32(
                    title: "Chapter 2-2",
                    name: widget.name,
                    life: widget.life)));
      }
    });
  }

  void handleChoice(Choice choice) {
    setState(() {
      if (choice.text == "ขาวเข้ม") {
        dialogs.addAll(dia1);
        showButtons = true;
        showChoices = false;
        diaCounter = dialogs.length - 5;
      } else {
        dialogs.addAll(dia2);
        showButtons = true;
        showChoices = false;
        diaCounter = dialogs.length - 1;
      }
    });
  }
}
