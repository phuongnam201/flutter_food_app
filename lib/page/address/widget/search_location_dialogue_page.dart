import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:food_app/controller/location_controller.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_places_flutter/model/prediction.dart';
import 'package:google_maps_webservice/places.dart';

class LocationDialogue extends StatelessWidget {
  final GoogleMapController mapController;
  const LocationDialogue({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimensions.width10),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius20 / 2),
        ),
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: SingleChildScrollView(
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _controller,
                textInputAction: TextInputAction.search,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  hintText: "Search your location",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    borderSide: BorderSide(style: BorderStyle.none, width: 0),
                  ),
                  hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                        color: Theme.of(context).disabledColor,
                        fontSize: Dimensions.font16,
                      ),
                ),
              ),
              onSuggestionSelected: (suggestion) {
                Get.find<LocationController>().setLocation(suggestion.placeId!,
                    suggestion.description!, mapController);
                Get.back();
              },
              suggestionsCallback: (pattern) async {
                return await Get.find<LocationController>()
                    .searchLocation(context, pattern);
              },
              itemBuilder: (context, Prediction suggestion) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.mainColor,
                      ),
                      Expanded(
                        child: Text(
                          suggestion.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.headline2?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color,
                                    fontSize: Dimensions.font16,
                                  ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

//*******************************************Test*************************************** */
//import 'package:flutter/material.dart';
//import 'package:food_app/controller/location_controller.dart';
//import 'package:get/get.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:google_places_flutter/model/prediction.dart';

//class SearchLocation extends StatelessWidget {
// const SearchLocation({super.key});

// @override
// Widget build(BuildContext context) {
//  TextEditingController controller = TextEditingController();
//  return Center();
//   child: GooglePlaceAutoCompleteTextField(
//     textEditingController: controller,
//     googleAPIKey: "AIzaSyAMOhgrgtmj5gWXZ3gsCnHglW-eEkhCVD4",
//     inputDecoration: InputDecoration(
//       hintText: "Search your location",
//       border: InputBorder.none,
//       enabledBorder: InputBorder.none,
//     ),
//     debounceTime: 400,
//     countries: ["vn"],
//     isLatLngRequired: true,
//     getPlaceDetailWithLatLng: (Prediction prediction) {
//       print("placeDetails" + prediction.lat.toString());
//     },

//     itemClick: (Prediction prediction) {
//       controller.text = prediction.description ?? "";
//     },
//     seperatedBuilder: Divider(),
//     containerHorizontalPadding: 10,

//     // OPTIONAL// If you want to customize list view item builder
//     itemBuilder: (context, index, Prediction prediction) {
//       return Container(
//         padding: EdgeInsets.all(10),
//         child: Row(
//           children: [
//             Icon(Icons.location_on),
//             SizedBox(
//               width: 7,
//             ),
//             Expanded(child: Text("${prediction.description ?? ""}"))
//           ],
//         ),
//       );
//     },

//     isCrossBtnShown: true,

//     // default 600 ms ,
//   ),
// );
// }
//}
