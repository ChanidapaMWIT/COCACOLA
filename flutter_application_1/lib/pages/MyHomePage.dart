import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Page02.dart';
import 'Page01.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  Page01 PA01 = Page01(title: "Enter your name");
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Choice {
  final String text;
  final String imagePath;

  Choice(this.text, this.imagePath);
}

class _MyHomePageState extends State<MyHomePage> {
  String welcomeText = 'Welcome to the Dialog Game!';

  List<Choice> choices = [
    Choice('Option 1', 'assets/03.png'),
    Choice('Option 2', 'assets/09.png'),
  ];

  int clickCounter = 0;
  int targetClicks = 100;
  String Opt = "Option 1";

  @override
  Widget build(BuildContext context) {
    widget.PA01.MHP = widget;
    return Scaffold(
        appBar: AppBar(
          title: Text('Dialog Game'),
        ),
        body: Container(
          width: double.infinity, // Take the full width of the screen
          height: double.infinity, // Take the full height of the screen
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/bg/ไปโรงเรียน.jpg'),
            fit: BoxFit.fill,
          )),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Dialog Box
                Text(
                  welcomeText,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),

                // 2. Choices Buttons
                // Column(
                //   children: choices.map((choice) {
                //     return Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       // child: ElevatedButton(
                //       //   onPressed: () {
                //       //     // Handle choice selection
                //       //     handleChoice(choice);
                //       //   },
                //       // child: Row(
                //       //   mainAxisAlignment: MainAxisAlignment.center,
                //       //   children: [
                //       //     Image.asset(
                //       //       choice.imagePath,
                //       //       width: 50,
                //       //       height: 50,
                //       //       fit: BoxFit.cover,
                //       //     ),
                //       //     SizedBox(width: 10),
                //       //     Text(choice.text),
                //       //   ],
                //       // ),
                //       //),
                //     );
                //   }).toList(),
                // ),

                // 3. Click Counter (Quick Time Event)
                // ElevatedButton(
                //   onPressed: () {
                //     // Handle click event
                //     handleButtonClick();
                //   },
                //   child: Text('Click me!'),
                // ),

                // // Display Click Counter
                // SizedBox(height: 20),
                // Text('Count: $clickCounter'),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => widget.PA01),
                    );
                  },
                  child: const Icon(Icons.arrow_circle_right),
                ),
              ],
            ),
          ),
        ));
  }

  void handleChoice(Choice choice) {
    // TODO: Handle choice logic
    setState(() {
      if (choice.text == "Option 1") {
        print("วาร์ปเลย");
      } else {
        print("ยังไม่วาร์ป");
      }
    });
    print('Selected: ${choice.text}');
  }

  void handleButtonClick() {
    setState(() {
      clickCounter++;
      if (clickCounter >= targetClicks) {
        // Player reached the target clicks, handle success
        print('Success! Clicked $clickCounter times.');
        resetClickCounter();
      }
    });
  }

  void resetClickCounter() {
    setState(() {
      clickCounter = 0;
    });
  }
}
