import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import '../../controllers/location_controller.dart';
import '../widgets/search_bar.dart';
import '../../brand_colors.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/submit_button.dart';

class LocationScreen extends StatelessWidget {
  final LocationController locationController = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey();

  showBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(title: 'Address type'),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: <Widget>[
                    CustomButton(
                      label: 'Home',
                      icon: OMIcons.home,
                    ),
                    CustomButton(
                      label: 'Office',
                      icon: OMIcons.work,
                    ),
                    CustomButton(
                      label: 'Resort',
                      icon: OMIcons.beachAccess,
                    ),
                    CustomButton(
                      label: 'Other',
                      icon: OMIcons.doneAll,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TitleText(title: 'building type'),
                GetBuilder<LocationController>(
                  builder: (_) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: DropdownButton<String>(
                            value: locationController.address!.buildingType,
                            items: locationController.buildingTypes
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              locationController.setBuildingType(newValue!);
                            },
                          ),
                        ),
                        (locationController.address!.buildingType == 'Building')
                            ? Flexible(
                                flex: 2,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: CustomTextFormField(
                                          label: 'Flat No.',
                                          keyboardType: TextInputType.number,
                                          onSave: (String? value) {
                                            locationController.address!.flatNo =
                                                value;
                                          },
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter flat number';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: CustomTextFormField(
                                          label: 'Floor No.',
                                          keyboardType: TextInputType.number,
                                          onSave: (String? value) {
                                            locationController
                                                .address!.floorNo = value;
                                          },
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter floor number';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ]),
                              )
                            : Flexible(flex: 2, child: Container())
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                TitleText(title: 'Address title'),
                CustomTextFormField(
                  label: 'Title',
                  onSave: (String? value) {
                    locationController.address!.addressTitle = value;
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter address title';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SubmitButton(
                    onPress: () {
                      if (!_formKey.currentState!.validate()) {
                        // Invalid!
                        return;
                      }
                      _formKey.currentState!.save();
                      print(locationController.address!.flatNo);
                    },
                    text: 'Save'),
              ],
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: GetBuilder<LocationController>(
              builder: (_) => (locationController.address == null)
                  ? Text("")
                  : Text(locationController.address!.placeFormattedAddress!)),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchBar());
              },
            ),
          ]),
      body: GetBuilder<LocationController>(
          builder: (_) => (locationController.isLoading == true)
              ? Center(child: CircularProgressIndicator())
              : (locationController.position == null)
                  ? Center(child: Text("Can't acess your location"))
                  : Column(children: <Widget>[
                      Expanded(
                        child: GoogleMap(
                          mapType: MapType.normal,
                          myLocationButtonEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                locationController.address!.latitude!,
                                locationController.address!.longitude!),
                            zoom: 14,
                          ),
                          myLocationEnabled: true,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          markers: {
                            Marker(
                              markerId: MarkerId('1'),
                              position: LatLng(
                                  locationController.address!.latitude!,
                                  locationController.address!.longitude!),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueRed),
                            )
                          },
                          onMapCreated: (GoogleMapController controller) {
                            locationController.mapController = controller;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        height: 70,
                        alignment: Alignment.topLeft,
                        child: TextButton.icon(
                          onPressed: () {
                            showBottomSheet(context);
                          },
                          icon: Icon(
                            Icons.location_on,
                            color: BrandColors.colorText,
                            size: 30,
                          ),
                          label: Text(
                            'choose this location',
                            style: TextStyle(
                              color: BrandColors.colorTextSemiLight,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    ])),
    );
  }
}

class TitleText extends StatelessWidget {
  final String title;
  TitleText({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: BrandColors.colorPrimaryDark,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final LocationController locationController = Get.find();
  final String label;
  IconData? icon;

  CustomButton({required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
        builder: (_) => ElevatedButton.icon(
              onPressed: () {
                locationController.setAddressType(label);
              },
              icon: Icon(
                icon,
                color: (locationController.address!.addressType == label)
                    ? Colors.white
                    : BrandColors.colorDarkGrey,
                size: 16,
              ),
              label: Text(
                label,
                style: TextStyle(
                  color: (locationController.address!.addressType == label)
                      ? Colors.white
                      : BrandColors.colorDarkGrey,
                  fontSize: 10,
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(16.0),
                ),
                side: BorderSide(
                  color: BrandColors.colorDarkGrey,
                  width: 1,
                ),
                primary: (locationController.address!.addressType == label)
                    ? Colors.blue
                    : Colors.white,
              ),
            ));
  }
}
