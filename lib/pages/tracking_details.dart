import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:entrega/models/tracking_model.dart';
import 'package:entrega/pages/home.dart';

class TrackingDetailsScreen extends StatelessWidget {
  final TrackingModel trackingModel;
  final HomePageState homePageState;
  final Function(TrackingModel) startTracking;

  const TrackingDetailsScreen({
    Key? key,
    required this.trackingModel,
    required this.homePageState,
    required this.startTracking,
  }) : super(key: key);

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        title: const Text("Tracking Details"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Tracker Information"),
            _infoCard([
              _infoRow(Icons.confirmation_number, "Tracker ID", trackingModel.tracker.trackerId),
              _infoRow(Icons.local_offer, "Tracking Number", trackingModel.tracker.trackingNumber),
              _infoRow(Icons.access_time, "Created At", _formatDateTime(trackingModel.tracker.createdAt)),
            ]),
            const SizedBox(height: 16),
            _sectionTitle("Recipient Information"),
            _infoCard([
              _infoRow(Icons.person, "Name", trackingModel.recipient.name),
              _infoRow(Icons.home, "Address", trackingModel.recipient.address),
              _infoRow(Icons.location_city, "City", trackingModel.recipient.city),
            ]),
            const SizedBox(height: 16),
            _sectionTitle("Tracking Events"),
            trackingModel.events.isNotEmpty
                ? Column(
                    children: trackingModel.events.map((event) {
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: Icon(Icons.local_shipping,
                              color: event == trackingModel.events.last ? Colors.green : Colors.blueAccent),
                          title: Text(
                            event.statusCategory ?? "Status",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Status: ${event.status ?? "N/A"}'),
                              Text('Date: ${_formatDateTime(event.occurrenceDatetime)}'),
                              Text('Location: ${event.location ?? "N/A"}'),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('No events available', style: TextStyle(color: Colors.grey)),
                  ),
            const SizedBox(height: 16),
            _sectionTitle("Key Timestamps"),
            _infoCard([
              _infoRow(Icons.warning, "Exception Date", _formatDateTime(trackingModel.timeStamps.exceptionDatetime)),
              _infoRow(Icons.check_circle, "Delivered Date", _formatDateTime(trackingModel.timeStamps.deliveredDatetime)),
            ]),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  Widget _infoCard(List<Widget> children) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: children),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueGrey),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "$label: ${value ?? "N/A"}",
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
