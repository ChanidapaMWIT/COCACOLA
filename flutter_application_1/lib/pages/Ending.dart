import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Page03.dart';
import 'EventPage.dart';
import 'ChoicePage.dart';

class Choice {
  final String text;
  final String imagePath;

  Choice(this.text, this.imagePath);
}

class Dialog {
  String char;
  String text;
  String imagePath;

  Dialog(this.char, this.text, this.imagePath);
}

class Ending extends StatefulWidget {
  Ending(
      {Key? key,
      required this.title,
      required this.name,
      required this.life,
      required this.endRoute})
      : super(key: key);
  final String title;
  final String name;
  final int life;
  final String endRoute;

  final myController = TextEditingController();
  //var PAch2 = ChoicePage(title: "Question A");

  @override
  State<Ending> createState() => _Page02State();
}

class _Page02State extends State<Ending> {
  late List<Dialog> dialogs;

  @override
  void initState() {
    super.initState();
    dialogs = [
      Dialog('แม่', '[${widget.name} ตื่นได้แล้วลูก !]', ''),
      Dialog('${widget.name}', 'ตื่นแล้วง้าบ !', ''),
      Dialog('${widget.name}', 'เฮ้อ...วันพุธแล้วสินะ', ''),
      Dialog('${widget.name}', 'วันพุธ...วันวาเลนไทน์นี่นา !', ''),
      Dialog('${widget.name}', 'งั้นวันนี้...จะต้องไปบอกชอบเธอให้ได้', ''),
      Dialog('', '[คุณหันไปเห็นไดอารี่ที่ตัวเองเขียน]', '')
    ];
    String Name = widget.name;
  }

  int diaCounter = 0;
  bool showChoices = false;
  bool showButtons = true;
  bool endChapter = false;

  List<Choice> choices = [
    Choice('อ่าน', 'assets/03.png'),
    Choice('ไม่อ่าน', 'assets/09.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 03'),
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
            image: AssetImage('assets/bg/school.jpg'),
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
                              previousDialog();
                            },
                            child: Text('Previous'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              nextDialog();
                            },
                            child: Text('Next'),
                          ),
                          ElevatedButton(
                            onPressed: () {
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
      ),
    );
  }

  void nextDialog() {
    setState(() {
      if (diaCounter >= dialogs.length - 1) {
        // Player reached the target clicks, handle success
        print('Success! Clicked $diaCounter times.');
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
      if (dialogs.length <= 6) {
        print('end dialog');
        showButtons = false;
        showChoices = true;
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Page03(
                    title: "Chapter 2", name: widget.name, life: widget.life)));
      }
    });
  }

  void handleChoice(Choice choice) {
    setState(() {
      if (choice.text == "อ่าน") {
        dialogs.addAll([
          Dialog(
              'diary',
              '[เนื้อหา : เธอชอบสีขาวเข้ม ชอบกินราดหน้าผัด ชอบนั่งเล่นไม่ยอมกลับบ้านจนเย็น]',
              ''),
          Dialog('', '[คุณรีบแต่งตัวไปโรงเรียน]', ''),
          Dialog(
              '',
              '[คุณรู้สึกว่าวันนี้ต้องเป็นวันที่พิเศษ อยากจะแต่งตัวให้เธอประทับใจสักหน่อย]',
              ''),
        ]);
        showButtons = true;
        showChoices = false;
        diaCounter = dialogs.length - 4;
      } else {
        dialogs.addAll([
          Dialog('', '[คุณรีบแต่งตัวไปโรงเรียน]', ''),
          Dialog(
              '',
              '[คุณรู้สึกว่าวันนี้ต้องเป็นวันที่พิเศษ อยากจะแต่งตัวให้เธอประทับใจสักหน่อย]',
              ''),
        ]);
        showButtons = true;
        showChoices = false;
        diaCounter = dialogs.length - 3;
      }
    });
  }
}
