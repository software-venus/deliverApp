import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:entrega/models/tracking_model.dart';
import 'package:entrega/pages/home.dart';
// import 'package:entrega/pages/user_login.dart';

// ignore: must_be_immutable
class TrackingDetailsScreen extends StatelessWidget {
  final TrackingModel trackingModel;
  HomePageState homePageState;
  final Function(TrackingModel) startTracking;

  TrackingDetailsScreen({
    super.key,
    required this.trackingModel,
    required this.homePageState,
    required this.startTracking,
  });

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            // Background gradient
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // Scrollable content
            Positioned.fill(
              top: 100,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: buildMainContent(context),
                  ),
                ),
              ),
            ),

            // Track button
            if (trackingModel.tracker.trackingNumber != "")
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if(!homePageState.isLogin){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Sign in to the site.")),
                        );
                      } else {
                        startTracking(trackingModel);
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text("Tracking started")),
                        // );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Track',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildMainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoCard('Tracker Information', [
          _infoRow(Icons.confirmation_number, 'Tracker ID', trackingModel.tracker.trackerId),
          _infoRow(Icons.local_offer, 'Tracking Number', trackingModel.tracker.trackingNumber),
          _infoRow(Icons.access_time, 'Created At', _formatDateTime(trackingModel.tracker.createdAt)),
        ]),
        const SizedBox(height: 16),
        _buildInfoCard('Recipient Information', [
          _infoRow(Icons.person, 'Name', trackingModel.recipient.name),
          _infoRow(Icons.home, 'Address', trackingModel.recipient.address),
          _infoRow(Icons.location_city, 'City', trackingModel.recipient.city),
        ]),
        const SizedBox(height: 20),
        Text(
          'Tracking Events',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 10),
        trackingModel.events.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: trackingModel.events.length,
                itemBuilder: (context, index) {
                  final event = trackingModel.events[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Icon(
                        Icons.local_shipping,
                        color: index == 0 ? Colors.green : Colors.blueAccent,
                        size: 32,
                      ),
                      title: Text(
                        event.statusCategory ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w600),
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
                style: TextStyle(color: Colors.white70),
              ),
        const SizedBox(height: 20),
        _buildInfoCard('Key Timestamps', [
          _infoRow(Icons.warning, 'Exception Date', _formatDateTime(trackingModel.timeStamps.exceptionDatetime)),
          _infoRow(Icons.check_circle, 'Delivered Date', _formatDateTime(trackingModel.timeStamps.deliveredDatetime)),
        ]),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueGrey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$label: ${value ?? "N/A"}',
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
