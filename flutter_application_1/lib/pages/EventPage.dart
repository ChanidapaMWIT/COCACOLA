import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/PageCh31.dart';
import 'package:flutter_application_1/pages/Ending.dart';

class ClickerGame {
  int clickCounter = 0;
}

class EventPage extends StatefulWidget {
  final ClickerGame clickerGame;
  final String name;
  final int life;
  EventPage(
      {Key? key,
      required this.clickerGame,
      required this.name,
      required this.life})
      : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int targetClicks = 20;
  int perfectClicks = 50; // Set your desired target clicks
  int remainingTime = 5;
  late Timer timer;

  @override
  // void initState() {
  //   super.initState();
  //   startTimer();
  // }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          // Game ends when the timer reaches 0
          endGame();
        }
      });
    });
  }

  void handleClick() {
    setState(() {
      widget.clickerGame.clickCounter++;
      if (widget.clickerGame.clickCounter == 1) {
        startTimer();
      }
      if (widget.clickerGame.clickCounter >= perfectClicks) {
        // Player reached the target clicks, game ends successfully
        endGame();
      }
      //if (widget.clickerGame.clickCounter >= targetClicks) {
      // Player reached the target clicks, game ends successfully
      //endGame();
      //}
    });
  }

  void endGame() {
    // Stop the timer
    timer.cancel();

    // Navigate to the result page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
            clickerGame: widget.clickerGame,
            success: widget.clickerGame.clickCounter >= targetClicks,
            name: widget.name,
            life: widget.life),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('เลือกจังหวะสับเท้าของคุณ !',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
        ),
        body: Center(
          child: Container(
            width: double.infinity, // Take the full width of the screen
            height: double.infinity, // Take the full height of the screen
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg/ไปโรงเรียน.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Remaining Time: $remainingTime seconds'),
                SizedBox(height: 20),
                Text('Clicks: ${widget.clickerGame.clickCounter}'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: handleClick,
                  child: Text('วิ่งงง!'),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }
}

//สร้างหน้า Result
class ResultPage extends StatelessWidget {
  final ClickerGame clickerGame;
  final bool success;
  final String name;
  final int life;

  ResultPage(
      {required this.clickerGame,
      required this.success,
      required this.name,
      required this.life});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(success ? 'Congratulations!' : 'Game Over!'),
            SizedBox(height: 20),
            Text('Total Clicks: ${clickerGame.clickCounter}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                clickerGame.clickCounter = 0;
                if (success) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Ch31(
                              title: "Chapter 2-1", name: name, life: life)));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Ending(
                                title: "Ending",
                                name: name,
                                life: 0,
                                endRoute: 'Late school',
                              )));
                }
              },
              child: Text('next'),
            ),
          ],
        ),
      ),
    );
  }
}
