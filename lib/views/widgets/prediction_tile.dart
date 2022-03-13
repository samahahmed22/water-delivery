import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/location_controller.dart';
import '../../models/prediction_model.dart';
import '../../brand_colors.dart';
import '../widgets/progress_dialog.dart';

class PredictionTile extends StatelessWidget {
  final PredictionModel? prediction;
  PredictionTile({this.prediction});

  final LocationController locationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        Get.defaultDialog(
            title: '',
            backgroundColor: Colors.white,
            barrierDismissible: false,
            content: ProgressDialog(
              status: 'Please wait...',
            ));

        await locationController.getPlaceDetails(prediction!.placeId!);

        Navigator.pop(context);
        Get.back();
      },
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on_outlined,
                  color: BrandColors.colorDimText,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        prediction!.mainText!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        prediction!.secondaryText!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: BrandColors.colorDimText,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
