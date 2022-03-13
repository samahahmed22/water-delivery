import 'package:flutter/material.dart';

import '../../brand_colors.dart';

class ProgressDialog extends StatelessWidget {
  final String status;
  ProgressDialog({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(BrandColors.colorAccent),
            ),
            SizedBox(
              width: 25.0,
            ),
            Text(
              status,
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
