import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting DateTime
import 'package:entrega/models/tracking_model.dart';

class TrackingDetailsScreen extends StatelessWidget {
  final TrackingModel trackingModel;

  const TrackingDetailsScreen({super.key, required this.trackingModel});

  // Helper method to format DateTime to a readable string
  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Tracking Details'),
      //   backgroundColor: Colors.blueAccent,
      //   elevation: 0,
      // ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600, // Limit the width for better centering on larger screens
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Section: Tracker and Recipient Details
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tracker Information',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                          ),
                          const SizedBox(height: 8),
                          Text('Tracker ID: ${trackingModel.tracker.trackerId ?? ""}'),
                          Text('Tracking Number: ${trackingModel.tracker.trackingNumber ?? ""}'),
                          Text('Created At: ${_formatDateTime(trackingModel.tracker.createdAt)}'),
                          const SizedBox(height: 16),
                          const Text(
                            'Recipient Information',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                          ),
                          const SizedBox(height: 8),
                          Text('Name: ${trackingModel.recipient.name ?? ""}'),
                          Text('Address: ${trackingModel.recipient.address ?? ""}'),
                          Text('City: ${trackingModel.recipient.city ?? ""}'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Middle Section: Events List
                  const Text(
                    'Tracking Events',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 10),
                  trackingModel.events.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true, // Important for nested scrolling
                          physics: const NeverScrollableScrollPhysics(), // Disable inner scroll
                          itemCount: trackingModel.events.length,
                          itemBuilder: (context, index) {
                            final event = trackingModel.events[index];
                            return Card(
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(12),
                                leading: Icon(
                                  Icons.local_shipping,
                                  color: index == 0 ? Colors.green : Colors.grey,
                                  size: 30,
                                ),
                                title: Text(
                                  event.statusCategory ?? "",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Status: ${event.status ?? ""}'),
                                    Text('Date: ${_formatDateTime(event.occurrenceDatetime)}'),
                                    Text('Location: ${event.location ?? ""}'),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const Text(
                          'No events available',
                          style: TextStyle(color: Colors.grey),
                        ),
                  const SizedBox(height: 20),

                  // Bottom Section: Timestamps
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Key Timestamps',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                          ),
                          const SizedBox(height: 8),
                          Text('Exception Date: ${_formatDateTime(trackingModel.timeStamps.exceptionDatetime)}'),
                          Text('Delivered Date: ${_formatDateTime(trackingModel.timeStamps.deliveredDatetime)}'),
                        ],
                      ),
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
}
