import 'package:flutter/material.dart';
import 'package:food_app/base/custom_button.dart';
import 'package:food_app/controller/location_controller.dart';
//import 'package:food_app/page/address/widget/search_location_dialogue_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap(
      {super.key,
      required this.fromSignup,
      required this.fromAddress,
      this.googleMapController});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _intialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _intialPosition = LatLng(21.582330177825217, 105.80709683450814);
      _cameraPosition = CameraPosition(target: _intialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _intialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(
                Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition = CameraPosition(target: _intialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _intialPosition,
                      zoom: 17,
                    ),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPositon) {
                      _cameraPosition = cameraPositon;
                    },
                    onCameraIdle: () {
                      Get.find<LocationController>()
                          .updatePosition2(_cameraPosition, false);
                    },
                    onMapCreated: (GoogleMapController mapController) {
                      _mapController = mapController;
                      if (widget.fromAddress) {}
                    },
                  ),
                  Center(
                    child: !locationController.loading
                        ? Image.asset(
                            "assets/image/pick_marker.png",
                            height: 50,
                            width: 50,
                          )
                        : CircularProgressIndicator(),
                  ),
                  Positioned(
                    top: Dimensions.height45,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child:
                        // locationController.isLoading
                        //     ? Center(
                        //         child: CircularProgressIndicator(),
                        //       ):
                        InkWell(
                      onTap: () => {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 25,
                              color: AppColors.mainBlackColor,
                            ),
                            Expanded(
                              child: Text(
                                '${locationController.pickPlacemark.name ?? ''}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.font16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.width10,
                            ),
                            Icon(
                              Icons.search,
                              size: 25,
                              color: AppColors.yellowColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: Center(
                      child: CustomButton(
                        //width: Dimensions.width20 * 10,
                        buttonText: "Pick address",
                        // locationController.inZone
                        //     ? widget.fromAddress
                        //         ? 'Pick Address'
                        //         : 'Pick Location'
                        //     : 'Service is not available',
                        onPressed: (locationController.buttonDisable ||
                                locationController.loading)
                            ? () {
                                print("debug at line 151 pick_address_page");
                              }
                            : () {
                                if (locationController.pickPosition.latitude !=
                                        0 &&
                                    locationController.pickPlacemark.name !=
                                        null) {
                                  if (widget.fromAddress) {
                                    if (widget.googleMapController != null) {
                                      //print("Now you can clicked on this");
                                      widget.googleMapController!.moveCamera(
                                          CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                  target: LatLng(
                                                    locationController
                                                        .pickPosition.latitude,
                                                    locationController
                                                        .pickPosition.longitude,
                                                  ),
                                                  zoom: 17)));
                                      locationController.setAddAddressData();
                                    }
                                    if (widget.fromAddress) {
                                      Get.toNamed(RouteHelper.getAddressPage());
                                    }
                                  }
                                }
                              },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
