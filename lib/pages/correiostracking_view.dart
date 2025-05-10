import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:entrega/models/tracking_model.dart';
import 'package:entrega/models/tracker_model.dart';
import 'package:entrega/models/event_model.dart';
import 'package:entrega/models/recipient_model.dart';
import 'package:entrega/models/timestamps.dart';
import 'package:entrega/variables/globalvar.dart';
import 'package:entrega/pages/home.dart';
import 'package:entrega/pages/tracking_details.dart'; // assume this exists

// ignore: must_be_immutable
class TrackingPage extends StatefulWidget {
  HomePageState homePageState;
  bool dobleClosed;

  TrackingPage({Key? key, required this.homePageState, required this.dobleClosed}) : super(key: key);

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  List<TrackingModel> myTrackings = [];

  @override
  void initState() {
    super.initState();
    loadTracksListView();
  }

  Future<void> loadTracksListView() async {
    try {
      final firestoreInstance = FirebaseFirestore.instance;
      CollectionReference tracks = firestoreInstance.collection(firebaseTracksKey);
      final querySnapshot = await tracks.where('username', isEqualTo: widget.homePageState.loginUsername).get();

      List<TrackingModel> loadedTrackings = [];

      for (var result in querySnapshot.docs) {
        final trackData = result.data() as Map<String, dynamic>;
        final tracker = TrackerModel.fromJSON(result.id, trackData['tracker']);
        final recipient = RecipientModel.fromJSON(result.id, trackData['shipment']['recipient']);
        final timeStamps = TimeStampsModel.fromJSON(result.id, trackData['statistics']['timestamps']);
        final events = (trackData['events'] as List<dynamic>)
            .map((e) => EventModel.fromJSON(e))
            .toList();

        final tracking = TrackingModel(
          result.id,
          trackData['company'],
          tracker,
          recipient,
          events,
          timeStamps,
        );

        loadedTrackings.add(tracking);
      }

      setState(() {
        myTrackings = loadedTrackings;
      });
    } catch (e) {
      print("Failed to load tracks: $e");
    }
  }

  void deleteTracking(String documentId) async {
    await FirebaseFirestore.instance.collection(firebaseTracksKey).doc(documentId).delete();
    setState(() {
      myTrackings.removeWhere((tracking) => tracking.key == documentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(menuTrackTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: myTrackings.isEmpty
            ? const Center(child: Text("No tracking data available"))
            : ListView.builder(
                itemCount: myTrackings.length,
                itemBuilder: (context, index) {
                  final tracking = myTrackings[index];
                  final lastEvent = tracking.events.isNotEmpty
                      ? tracking.events.last
                      : null;

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tracking Number: ${tracking.tracker.trackingNumber ?? "N/A"}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('Company: ${tracking.company}'),
                          if (lastEvent != null) ...[
                            Text('Status: ${lastEvent.status ?? "N/A"}'),
                            Text('Status Category: ${lastEvent.statusCategory ?? "N/A"}'),
                          ] else
                            const Text('No events available'),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => TrackingDetailsScreen(
                                        trackingModel: tracking,
                                        homePageState: widget.homePageState,
                                        startTracking: (t) {},
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('View'),
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () => deleteTracking(tracking.key),
                                child: const Text('Delete', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
