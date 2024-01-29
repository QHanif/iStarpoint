import 'package:flutter/material.dart';
import 'package:iStarpoint/util/eventdetails.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EventDetailPage extends StatefulWidget {
  final int eventIndex;

  const EventDetailPage({super.key, required this.eventIndex});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  XFile? _image;
  Future<void> pickImageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> event = eventDetails[widget.eventIndex];
    Map<String, dynamic> geotag = event['geotag'];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 237, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 237, 255),
        title: const Text('Event Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 0, 7, 112),
          ),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                  ),
                  const SizedBox(height: 10),
                  Text(
                    event['eventTitle'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color.fromARGB(255, 93, 0, 112),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 5),
                      Text('Date: ${event['eventDate']}'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.access_time),
                      const SizedBox(width: 5),
                      Text('Time: ${event['eventTime']}'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 5),
                      Text('Location: ${event['eventLocation']}'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(event['eventInfo']),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200, // Adjust as needed
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(geotag['latitude'], geotag['longitude']),
                        zoom: 17,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('eventLocation'),
                          position:
                              LatLng(geotag['latitude'], geotag['longitude']),
                          infoWindow: InfoWindow(
                            title: event['eventTitle'],
                            snippet: event['eventLocation'],
                          ),
                        ),
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Attendance Picture'),
                        const SizedBox(height: 10),
                        if (_image != null)
                          Image.file(File(_image!.path))
                        else
                          const Text('No image selected.'),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: pickImageFromCamera,
                          // style: ElevatedButton.styleFrom(
                          //   foregroundColor: Colors.white,
                          //   backgroundColor: Colors.blue,
                          // ),
                          child: const Text('Take a picture'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: (_image != null && !event['isJoin'])
                              ? () => _joinEvent()
                              : null,
                          // style: ElevatedButton.styleFrom(
                          //   foregroundColor: Colors.white,
                          //   backgroundColor: Colors.blue,
                          // ),
                          child:
                              Text(event['isJoin'] ? 'Joined' : 'Join Event'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _joinEvent() {
    setState(() {
      // Increase user's starpoints by 30 need user firebase logic fire
      //user.starpoints += 30;

      // Set the event's isJoin property to true
      eventDetails[widget.eventIndex]['isJoin'] = true;
    });
  }
}
