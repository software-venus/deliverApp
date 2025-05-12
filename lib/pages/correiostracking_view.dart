import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:entrega/models/tracking_model.dart';
import 'package:entrega/models/tracker_model.dart';
import 'package:entrega/models/event_model.dart';
import 'package:entrega/models/recipient_model.dart';
import 'package:entrega/models/timestamps.dart';
import 'package:entrega/variables/globalvar.dart';
import 'package:entrega/pages/home.dart';
import 'package:entrega/pages/tracking_details.dart';

// ignore: must_be_immutable
class TrackingPage extends StatefulWidget {
  HomePageState homePageState;
  bool dobleClosed;

  TrackingPage({Key? key, required this.homePageState, required this.dobleClosed})
      : super(key: key);

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
      CollectionReference tracks =
          firestoreInstance.collection(firebaseTracksKey);
      final querySnapshot = await tracks
          .where('username', isEqualTo: widget.homePageState.loginUsername)
          .get();

      List<TrackingModel> loadedTrackings = [];

      for (var result in querySnapshot.docs) {
        final trackData = result.data() as Map<String, dynamic>;
        final tracker = TrackerModel.fromJSON(result.id, trackData['tracker']);
        final recipient =
            RecipientModel.fromJSON(result.id, trackData['shipment']['recipient']);
        final timeStamps =
            TimeStampsModel.fromJSON(result.id, trackData['statistics']['timestamps']);
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
      appBar: AppBar(
        title: Text(menuTrackTitle),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: myTrackings.isEmpty
            ? const Center(
                child: Text(
                  "No tracking data available",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.separated(
                itemCount: myTrackings.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final tracking = myTrackings[index];
                  final lastEvent = tracking.events.isNotEmpty
                      ? tracking.events.last
                      : null;

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tracking.tracker.trackingNumber ?? "Tracking Number",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('Company: ${tracking.company}', style: const TextStyle(color: Colors.black54)),
                          const SizedBox(height: 4),
                          if (lastEvent != null) ...[
                            Text('Status: ${lastEvent.status ?? "N/A"}', style: const TextStyle(color: Colors.black87)),
                            Text('Category: ${lastEvent.statusCategory ?? "N/A"}', style: const TextStyle(color: Colors.black54)),
                          ] else
                            const Text('No events available', style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
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
                                icon: const Icon(Icons.visibility),
                                label: const Text('View'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton.icon(
                                onPressed: () => deleteTracking(tracking.key),
                                icon: const Icon(Icons.delete, color: Colors.red),
                                label: const Text('Delete', style: TextStyle(color: Colors.red)),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.red),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
