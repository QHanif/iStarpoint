import 'package:flutter/material.dart';

class EventPage extends StatelessWidget {
  Widget _event(
      String name, String date, String time, String venue, String imagePath,
      {bool isJoined = false}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 0, 7, 112),
      ),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  child: Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              ), // Add image at the start of the row
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25, // adjust the size as needed
                      color: Color.fromARGB(255, 93, 0, 112),
                    ),
                  ),
                  Text(
                    '$venue',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 93, 0, 112),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$date \n$time',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 139, 139, 139),
                    ),
                  ),
                  isJoined
                      ? Text('Joined', style: TextStyle(color: Colors.green))
                      : ElevatedButton(
                          onPressed: () {},
                          child: Text('Join Event'),
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
      backgroundColor: Color.fromARGB(255, 255, 237, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 237, 255),
        title: const Text('Events'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _event(
                "Flutter UI Design Workshop",
                "30 January 2024 ",
                "8:00 am - 12:00 pm",
                "Multi Perpose Hall, KICT",
                "assets/images/flutter.png"),
            _event(
              "Data Science Seminar",
              "15 February 2024",
              "10:00 am - 2:00 pm",
              "Conference Room, KICT",
              "assets/images/datascience.png",
            ),
            _event(
              "Cybersecurity Workshop",
              "20 March 2024",
              "9:00 am - 1:00 pm",
              "Lab 5, KICT",
              "assets/images/cybersecurity.png",
            ),
            _event(
              "AI and Machine Learning Talk",
              "25 April 2024",
              "11:00 am - 3:00 pm",
              "Auditorium, KICT",
              "assets/images/ai_ml.png",
            ),
            _event(
              "Web Development Bootcamp",
              "30 May 2024",
              "8:00 am - 12:00 pm",
              "Lab 6, KICT",
              "assets/images/webdev.png",
            ),
            _event(
              "Cloud Computing Symposium",
              "10 June 2024",
              "9:00 am - 1:00 pm",
              "Conference Room, KICT",
              "assets/images/cloudcomputing.png",
            ),
          ],
        ),
      ),
    );
  }
}
