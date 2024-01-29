// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Page05.dart';
import 'EventPage.dart';

//Step 4
// ignore: must_be_immutable
class Page04 extends StatefulWidget {
  Page04(
      {Key? key, required this.title, required this.name, required this.life})
      : super(key: key);
  final String title;
  final String name;
  int life;

  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names

  @override
  State<Page04> createState() => _MyHomePageState();
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
class _MyHomePageState extends State<Page04> {
  late List<Dialog> dialogs;

  @override
  void initState() {
    super.initState();
    dialogs = [
      Dialog(
          'เธอ', 'วันนี้กินอะไรดีน้าาาา', 'assets/character/you/You_idle.png'),
    ];

    String Name = widget.name;
  }

  int diaCounter = 0;

  bool showChoices = false;
  bool showButtons = true;

  List<Choice> choices = [
    Choice('ก๋วยเตี๋ยวทอด', 'assets/item/ก๋วยเตี๋ยวทอด.PNG'),
    Choice('ต้มซีอิ๊ว', 'assets/item/ต้มซีอิ๊ว.PNG'),
    Choice('ราดหน้าผัด', 'assets/item/ราดหน้าผัด.PNG'),
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
      if (dialogs.length == 1) {
        print('end dialog');
        showButtons = false;
        showChoices = true;
      }
      //
      else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Page05(
                    title: 'Chapter 4', name: widget.name, life: widget.life)));
      }
    });
  }

  void handleChoice(Choice choice) {
    setState(() {
      if (choice.text == "ราดหน้าผัด") {
        dialogs.addAll([
          Dialog('เธอ', 'จำของโปรดฉันได้ด้วยเหรอ',
              'assets/character/you/You_Happy.png'),
          Dialog('${widget.name}', 'แน่นอนนนน', ''),
          Dialog('เธอ', 'ฉันก็จำได้ว่าเธอชอบกินต้มซีอิ๊ว',
              'assets/character/you/You_smile.png'),
          Dialog('${widget.name}', 'จำได้ด้วย เก่งจัง', ''),
          Dialog('${widget.name}', ' งั้นเราไปซื้อแล้วนั่งนั่นกัน', ''),
        ]);
        showButtons = true;
        showChoices = false;
        diaCounter = dialogs.length - 5;
        widget.life += 1;
      } else {
        dialogs.addAll([
          Dialog('เธอ', 'ไม่ค่อยชอบหรอก แต่ก็กินได้',
              'assets/character/you/You_bored.png'),
          Dialog('${widget.name}', 'อ้าวเหรอ นึกว่าเธอชอบ',
              'assets/character/Me_sad.png'),
          Dialog('เธอ', 'ฉันยังจำได้เลยว่าเธอชอบอะไร',
              'assets/character/you/You_talk.png'),
          Dialog('${widget.name}', 'อะไร', 'assets/character/Me_sad.png'),
          Dialog('เธอ', 'ต้มซีอิ๊วไง', 'assets/character/you/You_angry.png'),
          Dialog('เธอ', '...', 'assets/character/you/You_pissed.png'),
        ]);
        showButtons = true;
        showChoices = false;
        diaCounter = dialogs.length - 6;
        widget.life -= 1;
      }
    });
  }
}
