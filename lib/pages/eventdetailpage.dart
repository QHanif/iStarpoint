import 'package:flutter/material.dart';
import 'package:iStarpoint/util/eventdetails.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventDetailPage extends StatefulWidget {
  final int eventIndex;

  const EventDetailPage({super.key, required this.eventIndex});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> event = eventDetails[widget.eventIndex];
    Map<String, dynamic> geotag = event['geotag'];

    return Scaffold(
      appBar: AppBar(
        title: Text(event['eventTitle']),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                event['eventPicture'],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Text('Date: ${event['eventDate']}'),
          Text('Time: ${event['eventTime']}'),
          Text('Location: ${event['eventLocation']}'),
          Text(event['eventInfo']),
          SizedBox(
            height: 200, // Adjust as needed
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(geotag['latitude'], geotag['longitude']),
                zoom: 14.4746,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: event['isJoin'] ? null : () => _joinEvent(),
            child: Text(event['isJoin'] ? 'Joined' : 'Join Event'),
          ),
        ],
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
