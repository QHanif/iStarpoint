import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int points = 0;

  void catShow() {
    setState(() {
      points += 30;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of events'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 150.0, // specify the height
              width: 200.0,
              child: ElevatedButton(
                onPressed: () {
                  // Put your code here for button 1
              },
                child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/ai-generated-8270714_640.png', height: 100, width:100), // replace with your image path
                    const Text('Annual Cat Show'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 150.0, // specify the height
              width: 200.0,
              child: ElevatedButton(
                onPressed: () {
                  // Put your code here for button 1
              },
                child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/pexels-tima-miroshnichenko-5380610.jpg', height: 100, width:100), // replace with your image path
                    Text('Cybersecurity Camp'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


