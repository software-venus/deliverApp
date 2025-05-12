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
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: const Color(0xFFF2F5F9),
              ),
            ),
            Column(
              children: [
                if (trackingModel.tracker.trackingNumber != "")
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (!homePageState.isLogin) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Sign in to the site.")),
                          );
                        } else {
                          startTracking(trackingModel);
                        }
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("Track"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle("Tracker Information"),
                        _buildCard([
                          _infoRow(Icons.confirmation_number, "Tracker ID", trackingModel.tracker.trackerId),
                          _infoRow(Icons.local_offer, "Tracking Number", trackingModel.tracker.trackingNumber),
                          _infoRow(Icons.access_time, "Created At", _formatDateTime(trackingModel.tracker.createdAt)),
                        ]),
                        _sectionTitle("Recipient Information"),
                        _buildCard([
                          if(trackingModel.recipient.name!="") _infoRow(Icons.person, "Name", trackingModel.recipient.name),
                          _infoRow(Icons.home, "Address", trackingModel.recipient.address),
                          if(trackingModel.recipient.city!="")_infoRow(Icons.location_city, "City", trackingModel.recipient.city),
                        ]),
                        _sectionTitle("Tracking Events"),
                        trackingModel.events.isNotEmpty
                            ? Column(
                                children: trackingModel.events.map((event) {
                                  return Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    elevation: 2,
                                    margin: const EdgeInsets.symmetric(vertical: 8),
                                    child: ListTile(
                                      leading: Icon(Icons.local_shipping,
                                          color: event == trackingModel.events.last ? Colors.green : Colors.blueAccent),
                                      title: Text(event.statusCategory ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(event.location ?? ""),
                                          Text(event.status ?? ""),
                                          Text(_formatDateTime(event.occurrenceDatetime)),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )
                            : const Text('No events available', style: TextStyle(color: Colors.grey)),
                        _sectionTitle("Key Timestamps"),
                        _buildCard([
                          _infoRow(Icons.warning, "Exception Date", _formatDateTime(trackingModel.timeStamps.exceptionDatetime)),
                          _infoRow(Icons.check_circle, "Delivered Date", _formatDateTime(trackingModel.timeStamps.deliveredDatetime)),
                        ]),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
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
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "$label: ${value ?? "N/A"}",
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
