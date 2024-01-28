import 'package:flutter/material.dart';
import 'package:iStarpoint/util/eventdetails.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  Widget _event(BuildContext context, Map<String, dynamic> event) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 0, 7, 112),
      ),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  event['eventPicture'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ), // Add image at the start of the row
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['eventTitle'],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25, // adjust the size as needed
                      color: Color.fromARGB(255, 93, 0, 112),
                    ),
                  ),
                  Text(
                    event['eventLocation'],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 93, 0, 112),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${event['eventDate']} \n${event['eventTime']}',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 139, 139, 139),
                    ),
                  ),
                  event['isJoin']
                      ? const Text('Joined',
                          style: TextStyle(color: Colors.green))
                      : ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/eventdetail',
                              arguments: eventDetails.indexOf(event),
                            );
                          },
                          child: const Text('Join Event'),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 237, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 237, 255),
        title: const Text('Events'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: eventDetails
              .map((event) => _event(context, event)) // Pass context to _event
              .toList(), //  Use the eventDetails list to create the event widgets
        ),
      ),
    );
  }
}
