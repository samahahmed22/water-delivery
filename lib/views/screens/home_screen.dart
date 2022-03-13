import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../brand_colors.dart';

class HomeScreen extends StatelessWidget {
  void showBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose delivery address',
                style: TextStyle(
                  color: BrandColors.colorBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Get.toNamed('location');
                },
                icon: Icon(
                  Icons.add_circle_rounded,
                  color: Colors.blue,
                  size: 30,
                ),
                label: Text(
                  'Add address',
                  style: TextStyle(
                      color: BrandColors.colorText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                  ),
                  side: BorderSide(
                    color: BrandColors.colorLightGrey,
                    width: 1,
                  ),
                  primary: Colors.white,
                  minimumSize: Size.fromHeight(50),
                ),
              ),
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label: 'home',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
            label: 'orders', 
            icon: Icon(Icons.money_off_csred_sharp)),
      ],
      currentIndex: 0,
      onTap: (index) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset:true,
      appBar: AppBar(
        title: Row(children: <Widget>[
          Text(
            "Deliver To ",
            style: TextStyle(
              color: BrandColors.colorText,
              fontSize: 15.0,
            ),
          ),
          Flexible(
            child: TextButton(
                onPressed: () {
                  showBottomSheet(context);
                },
                child: Text(
                  'Choose delivery address',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: BrandColors.colorPrimaryDark,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
        ]),
        actions: [
          AppBarIcon(
              icon: Icons.keyboard_arrow_down,
              onPress: () => showBottomSheet(context)),
          AppBarIcon(icon: Icons.add_alert_sharp, onPress: () {}),
          AppBarIcon(icon: Icons.shopping_cart, onPress: () {}),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
}

class AppBarIcon extends StatelessWidget {
  IconData icon;
  final VoidCallback onPress;

  AppBarIcon({
    required this.icon,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      child: IconButton(
        icon: Icon(
          icon,
        ),
        color: BrandColors.colorPrimaryDark,
        onPressed: onPress,
      ),
    );
  }
}
