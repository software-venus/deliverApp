class TrackerModel {
  String? key;
  String? trackerId;
  String? trackingNumber;
  String? shipmentReference;
  List<dynamic>? courierCode;
  String? clientTrackerId;
  bool? isSubscribed;
  bool? isTracked;
  

  DateTime? createdAt;

  TrackerModel(
      this.key,
      this.trackerId,
      this.trackingNumber,
      this.shipmentReference,
      this.courierCode,
      this.clientTrackerId,
      this.isSubscribed,
      this.isTracked,
      this.createdAt);

  factory TrackerModel.fromJSON(
      String key, dynamic jsonData) {
    return TrackerModel(
        key,
        jsonData['trackerId'] as String?,
        jsonData['trackingNumber'] as String?,
        jsonData['shipmentReference'] as String?,
        jsonData['courierCode'] as List<dynamic>?,
        jsonData['clientTrackerId'] as String?,

        jsonData['isSubscribed'] as bool?,
        jsonData['isTracked'] as bool?,
        DateTime.parse(
            jsonData['createdAt']));
  }

  factory TrackerModel.fromJSONWithIdToKey(
      String key, dynamic jsonData) {
    return TrackerModel(
        key,
        jsonData['trackerId'] as String,
        jsonData['trackingNumber'] as String,
        jsonData['shipmentReference'] as String,
        jsonData['courierCode'] as List<String>,
        jsonData['clientTrackerId'] as String,
        jsonData['isSubscribed'] as bool,
        jsonData['isTracked'] as bool,
        DateTime.fromMicrosecondsSinceEpoch(
            jsonData['createAt'].microsecondsSinceEpoch));
  }

  Map<String, dynamic> toJson() => {
        'trackerid': trackerId,
        'trackingNumber': trackingNumber,
        'shipmentReference': shipmentReference,
        'courierCode': courierCode,
        'clientTrackerId': clientTrackerId,
        'isSubscribed': isSubscribed,
        'isTracked': isTracked,
        'createAt': createdAt
      };

  // Map<String, dynamic> toJsonWithExportKeyToId() => {
  //       'id': key,
  //       'title': title,
  //       'detail': detail,
  //       'price': price,
  //       'maxTracks': maxTracks,
  //       'isAds': isAds,
  //       'creationTime': creationTime,
  //     };

  // void updateFrom(MembershipModel fromMembership) {
  //   exportKeyToId = fromMembership.exportKeyToId;
  //   key = fromMembership.key;

  //   title = fromMembership.title;
  //   detail = fromMembership.detail;
  //   price = fromMembership.price;

  //   maxTracks = fromMembership.maxTracks;

  //   isAds = fromMembership.isAds;

  //   creationTime = DateTime.now().add(const Duration(days: 30));
  // }
}
