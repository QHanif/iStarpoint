import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

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
            SizedBox(
              height: 150.0, // specify the height
              width: 200.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/eventdetail',
                    arguments: 0, // index of the event in the eventDetails list
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/ai-generated-8270714_640.png',
                        height: 100,
                        width: 100), // replace with your image path
                    const Text('Annual Cat Show'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 150.0, // specify the height
              width: 200.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/eventdetail',
                    arguments: 1, // index of the event in the eventDetails list
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/pexels-tima-miroshnichenko-5380610.jpg',
                        height: 100,
                        width: 100), // replace with your image path
                    const Text('Cybersecurity Camp'),
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
