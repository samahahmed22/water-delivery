import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/location_controller.dart';
import './prediction_tile.dart';
import '../../models/prediction_model.dart';

class SearchBar extends SearchDelegate {
  final LocationController locationController = Get.find<LocationController>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<PredictionModel> suggestionList = [];
    if (query.isEmpty) {
      suggestionList = [];
    } else {
      locationController.searchPlace(query);
      suggestionList = locationController.predictionList;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.separated(
        padding: EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return PredictionTile(
            prediction: suggestionList[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 1.0,
          color: Color(0xFFe2e2e2),
          thickness: 1.0,
        ),
        itemCount: suggestionList.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}
