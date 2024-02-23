import 'package:flutter/material.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationDialogue extends StatelessWidget {
  final GoogleMapController mapController;
  const LocationDialogue({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius20 / 2),
        ),
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: Container(
            child: Text("Google map search"),
          ),
        ),
      ),
    );
  }
}
