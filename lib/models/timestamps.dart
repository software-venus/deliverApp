class TimeStampsModel {
  String key;
  DateTime? infoReceivedDatetime;
  DateTime? inTransitDatetime;
  DateTime? outForDeliveryDatetime;
  DateTime? failedAttemptDatetime;
  DateTime? availableForPickupDatetime;
  DateTime? exceptionDatetime;
  DateTime? deliveredDatetime;

  TimeStampsModel(
    this.key,
    this.infoReceivedDatetime,
    this.inTransitDatetime,
    this.outForDeliveryDatetime,
    this.failedAttemptDatetime,
    this.availableForPickupDatetime,
    this.exceptionDatetime,
    this.deliveredDatetime
  );

  factory TimeStampsModel.fromJSON(String key, dynamic jsonData) {
    return TimeStampsModel(
      key,
      jsonData['infoReceivedDatetime'] as DateTime?,
      jsonData['inTransitDatetime'] as DateTime?,
      jsonData['outForDeliveryDatetime'] as DateTime?,
      jsonData['failedAttemptDatetime'] as DateTime?,
      jsonData['availableForPickupDatetime'] as DateTime?,
      jsonData['exceptionDatetime'] as DateTime?,
      jsonData['deliveredDatetime'] as DateTime?,
    );
  }

  Map<String, dynamic> toJson() => {
        'infoReceivedDatetime': infoReceivedDatetime,
        'inTransitDatetime': inTransitDatetime,
        'outForDeliveryDatetime': outForDeliveryDatetime,
        'failedAttemptDatetime': failedAttemptDatetime,
        'availableForPickupDatetime': availableForPickupDatetime,
        'exceptionDatetime': exceptionDatetime,
        'deliveredDatetime': deliveredDatetime,
      };
}
