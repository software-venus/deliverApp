class RecipientModel {
  String key;
  String name;
  String address;
  String postCode;
  String city;
  String subdivision;

  RecipientModel(
    this.key,
    this.name,
    this.address,
    this.postCode,
    this.city,
    this.subdivision
  );

  factory RecipientModel.fromJSON(String key, dynamic jsonData) {
    return RecipientModel(
      key,
      jsonData['name'] as String,
      jsonData['address'] as String,
      jsonData['postCode'] as String,
      jsonData['city'] as String,
      jsonData['subdivision'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'postCode': postCode,
        'city': city,
        'subdivision': subdivision,
      };
}
