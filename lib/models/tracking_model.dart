import 'package:entrega/models/event_model.dart';
import 'package:entrega/models/recipient_model.dart';
import 'package:entrega/models/timestamps.dart';
import 'package:entrega/models/tracker_model.dart';

class TrackingModel {
  String key;
  TrackerModel tracker;
  RecipientModel recipient;
  List<EventModel> events;
  TimeStampsModel timeStamps;

  TrackingModel(
    this.key,
    this.tracker,
    this.recipient,
    this.events,
    this.timeStamps
  );

  
}
