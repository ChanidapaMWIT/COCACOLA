import 'package:flutter/material.dart';
import 'Page02.dart';

//Step 4
// ignore: must_be_immutable
class Page01 extends StatefulWidget {
  Page01({super.key, required this.title});

  final String title;
  final myController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  var MHP;
  // ignore: non_constant_identifier_names
  var PA02 = Page02(title: "Chapter 1", name: '', life: 3);

  @override
  State<Page01> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Page01> {
  TextEditingController nameController = TextEditingController();
  String name = 'y/n';

  @override
  Widget build(BuildContext context) {
    // widget.myController.text = widget.data;
    widget.PA02.PA01 = widget;
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),

        //#Start Body Center
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Enter your name'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    name = nameController.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Page02(title: "Chapter 1", name: name, life: 3),
                      ),
                    );
                  });
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),

        //-------------------------------------------------------------------------------

        //#Start Floating Action Butto #-------------------------------------------------
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        widget.PA02), // เปลี่ยนไปที่หน้า HomePage02
              );
            },
            child: const Icon(Icons.arrow_circle_right_outlined),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        widget.MHP), // เปลี่ยนไปที่หน้า HomePage
              );
            },
            child: const Icon(Icons.arrow_circle_left_outlined),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => (),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => (),
            child: const Icon(Icons.delete),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => (),
            child: const Icon(Icons.exit_to_app),
          )
        ])
        //----------------------------------------------------------------------
        );
  }
}
