class MembershipModel {
  bool exportKeyToId;
  String key;

  String title;
  String detail;
  double price;
  int maxTracks;
  bool isAds;

  DateTime creationTime;

  MembershipModel(
      this.exportKeyToId,
      this.key,
      this.title,
      this.detail,
      this.price,
      this.maxTracks,
      this.isAds,
      this.creationTime);

  factory MembershipModel.fromJSON(
      bool exportKeyToId, String key, dynamic jsonData) {
    return MembershipModel(
        exportKeyToId,
        key,
        jsonData['title'] as String,
        jsonData['detail'] as String,
        jsonData['price'] is double
            ? jsonData['price'] as double
            : double.parse(jsonData['price'].toString()),
        jsonData['maxTracks'] as int,

        jsonData['isAds'] as bool,
        DateTime.fromMicrosecondsSinceEpoch(
            jsonData['creationTime'].microsecondsSinceEpoch));
  }

  factory MembershipModel.fromJSONWithIdToKey(
      bool exportKeyToId, String key, dynamic jsonData) {
    return MembershipModel(
        exportKeyToId,
        jsonData['id'] as String,
        jsonData['title'] as String,
        jsonData['detail'] as String,
        jsonData['price'] is double
            ? jsonData['price'] as double
            : double.parse(jsonData['price'].toString()),
        jsonData['maxTracks'] as int,
        jsonData['isAds'] as bool,
        DateTime.fromMicrosecondsSinceEpoch(
            jsonData['creationTime'].microsecondsSinceEpoch));
  }

  Map<String, dynamic> toJson() => {
        if (exportKeyToId) 'id': key,
        'title': title,
        'detail': detail,
        'price': price,
        'maxTracks': maxTracks,
        'isAds': isAds,
        'creationTime': creationTime,
      };

  Map<String, dynamic> toJsonWithExportKeyToId() => {
        'id': key,
        'title': title,
        'detail': detail,
        'price': price,
        'maxTracks': maxTracks,
        'isAds': isAds,
        'creationTime': creationTime,
      };

  void updateFrom(MembershipModel fromMembership) {
    exportKeyToId = fromMembership.exportKeyToId;
    key = fromMembership.key;

    title = fromMembership.title;
    detail = fromMembership.detail;
    price = fromMembership.price;

    maxTracks = fromMembership.maxTracks;

    isAds = fromMembership.isAds;

    creationTime = DateTime.now();
  }
}
