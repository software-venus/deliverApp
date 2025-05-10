import 'package:entrega/models/event_model.dart';
import 'package:entrega/models/recipient_model.dart';
import 'package:entrega/models/timestamps.dart';
import 'package:entrega/models/tracker_model.dart';

class TrackingModel {
  String key;
  String company;
  TrackerModel tracker;
  RecipientModel recipient;
  List<EventModel> events;
  TimeStampsModel timeStamps;

  TrackingModel(
    this.key,
    this.company,
    this.tracker,
    this.recipient,
    this.events,
    this.timeStamps
  );

  // factory TrackingModel.fromJSON(
  //     String key, dynamic jsonData) {
  //   return TrackingModel(
  //     key,
  //     jsonData['company'] as String? ?? '',
  //     TrackerModel.fromJSON('tracker', jsonData['tracker']),
  //     RecipientModel.fromJSON('recipient', jsonData['recipient']),
  //     jsonData['events'].length!=0?jsonData['events']
  //       .map((eventJson) => EventModel.fromJSON(eventJson))
  //       .toList():[],
  //     TimeStampsModel.fromJSON('timeStamps', jsonData['timeStamps']));
  // }

  
}
