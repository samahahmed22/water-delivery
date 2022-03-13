class AddressModel {
  String? addressTitle;
  double? latitude;
  double? longitude;
  String? placeId;
  String? placeFormattedAddress;
  String? buildingType;
  String? floorNo;
  String? flatNo;
  String? addressType;

  AddressModel(
      {this.placeId,
      this.latitude,
      this.longitude,
      this.addressTitle,
      this.placeFormattedAddress,
      this.buildingType = 'Building',
      this.floorNo,
      this.flatNo,
      this.addressType});
}
