import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants.dart';
import '../services/request_service.dart';
import '../models/prediction_model.dart';
import '../models/adress_model.dart';

class LocationController extends GetxController {
  bool isLoading = false;

  Position? position;
  AddressModel? address;
  List<PredictionModel> predictionList = <PredictionModel>[];

  GoogleMapController? mapController;

  List<String> buildingTypes = ['Building', 'Villa'];

  @override
  void onInit() async {
    // TODO: implement onInit
    getCurrentLocation();
   
    super.onInit();
  }

  void getCurrentLocation() async {
    isLoading = true;
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    position = await Geolocator.getCurrentPosition();

    AddressModel thisPlace = AddressModel();
    // thisPlace.placeId = position.;
    thisPlace.latitude = position!.latitude;
    thisPlace.longitude = position!.longitude;
    Placemark placemark =
        await getAdressFromCoordinates(position!.latitude, position!.longitude);
    String street = placemark.street!;
    String locality = placemark.locality!;
    String country = placemark.country!;
    thisPlace.placeFormattedAddress = '$street ,$locality ,$country';
    address = thisPlace;
    isLoading = false;
    update();
  }

  Future<Placemark> getAdressFromCoordinates(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

    return placemarks[0];
  }

  void searchPlace(String placeName) async {
    if (placeName.length > 1) {
      String url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=123254251&components=country:eg';
      var response = await RequestService.getRequest(url);

      if (response == 'failed') {
        predictionList = [];
      }

      if (response['status'] == 'OK') {
        var predictionJson = response['predictions'];
        predictionList = (predictionJson as List)
            .map((e) => PredictionModel.fromJson(e))
            .toList();
      }
    }
  }

  Future<AddressModel?> getPlaceDetails(String placeID) async {
    isLoading = true;

    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=$mapKey';

    var response = await RequestService.getRequest(url);
    AddressModel thisPlace = AddressModel();
    if (response == 'failed') {
      return null;
    }
    if (response['status'] == 'OK') {
      thisPlace.placeId = placeID;
      thisPlace.latitude = response['result']['geometry']['location']['lat'];
      thisPlace.longitude = response['result']['geometry']['location']['lng'];
      thisPlace.placeFormattedAddress = response['result']['formatted_address'];

      setAddress(thisPlace);
    }

    isLoading = false;

    return thisPlace;
  }

  void setAddress(AddressModel thisAddress) {
    address = thisAddress;
    LatLng pos = LatLng(address!.latitude!, address!.longitude!);
    CameraPosition cp = new CameraPosition(target: pos, zoom: 14);
    mapController!.animateCamera(CameraUpdate.newCameraPosition(cp));
    update();
  }

  void setBuildingType(String buildingType){
    address!.buildingType =  buildingType;
    update();
  }

  void setAddressType(String addressType){
    address!.addressType =  addressType;
    update();
  }
}
