class EventModel {
  String? eventId;
  String? trackingNumber;
  String? eventTrackingNumber;
  String? status;
  DateTime? occurrenceDatetime;
  String? order;
  String? location;
  String? sourceCode;
  String? courierCode;
  String? statusCategory;
  String? statusMilestone;

  EventModel(
    this.eventId,
    this.trackingNumber,
    this.eventTrackingNumber,
    this.status,
    this.occurrenceDatetime,
    this.order,
    this.location,
    this.sourceCode,
    this.courierCode,
    this.statusCategory,
    this.statusMilestone
  );

  factory EventModel.fromJSON(dynamic jsonData) {
    return EventModel(
      jsonData['eventId'] as String?,
      jsonData['trackingNumber'] as String?,
      jsonData['eventTrackingNumber'] as String?,
      jsonData['status'] as String?,
      jsonData['occurrenceDatetime'] as DateTime?,
      jsonData['order'] as String?,
      jsonData['location'] as String?,
      jsonData['sourceCode'] as String?,
      jsonData['courierCode'] as String?,
      jsonData['statusCategory'] as String?,
      jsonData['statusMilestone'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'trackingNumber': trackingNumber,
        'eventTrackingNumber': eventTrackingNumber,
        'status': status,
        'occurrenceDatetime': occurrenceDatetime,
        'order': order,
        'location': location,
        'sourceCode': sourceCode,
        'courierCode': courierCode,
        'statusCategory': statusCategory,
        'statusMilestone': statusMilestone
      };
}
