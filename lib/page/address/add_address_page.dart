import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/controller/location_controller.dart';
import 'package:food_app/controller/user_controller.dart';
import 'package:food_app/models/address_model.dart';
import 'package:food_app/page/address/pick_address_map.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/app_text_field.dart';
import 'package:food_app/widget/big_text.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();

  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(
      target: LatLng(21.58078484371705, 105.80662369893575), zoom: 17);
  late LatLng _initialPosition =
      const LatLng(21.58078484371705, 105.80662369893575);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
          "") {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }

      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress["latitude"]),
              double.parse(
                  Get.find<LocationController>().getAddress["longitude"])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Địa chỉ"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (userController.userModel != null &&
              _contactPersonName.text.isEmpty) {
            _contactPersonName.text = '${userController.userModel?.name}';
            _contactPersonNumber.text = '${userController.userModel?.phone}';
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text =
                  Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text =
                  '${locationController.placemark.name ?? ''}'
                  '${locationController.placemark.locality ?? ''}'
                  '${locationController.placemark.country ?? ''}';
              print("address in my view: " + _addressController.text);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      margin: EdgeInsets.all(Dimensions.width20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: _initialPosition, zoom: 17),
                            onTap: (latlng) {
                              Get.toNamed(RouteHelper.getPickAddressPage(),
                                  arguments: PickAddressMap(
                                    fromSignup: false,
                                    fromAddress: true,
                                    googleMapController:
                                        locationController.mapController,
                                  ));
                            },
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            //myLocationEnabled: true,
                            onCameraIdle: () {
                              locationController.updatePosition(
                                  _cameraPosition, true);
                            },
                            onCameraMove: ((position) =>
                                _cameraPosition = position),
                            onMapCreated: (GoogleMapController controller) {
                              locationController.setMapController(controller);
                            },
                          ),
                          /**get your location */
                          // Positioned(
                          //   bottom: 16.0,
                          //   right: 16.0,
                          //   child: FloatingActionButton(
                          //     onPressed: () async {
                          //       Position curr_position =
                          //           await locationController
                          //               .determinePosition();
                          //       print("current lat: " +
                          //           curr_position.latitude.toString());
                          //       print("current lng: " +
                          //           curr_position.longitude.toString());
                          //       _cameraPosition = CameraPosition(
                          //           target: LatLng(curr_position.latitude,
                          //               curr_position.longitude),
                          //           zoom: 17);
                          //       locationController.updatePosition(
                          //           _cameraPosition, true);
                          //     },
                          //     tooltip: 'Get My Location',
                          //     child: Icon(Icons.location_searching_sharp),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width20),
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                locationController.addressTypeList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  locationController.setAddressTypeIndex(index);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width20,
                                      vertical: Dimensions.height10),
                                  margin: EdgeInsets.only(
                                      right: Dimensions.width10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius10),
                                      color: Theme.of(context).cardColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[200]!,
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                        )
                                      ]),
                                  child: Row(
                                    children: [
                                      Icon(
                                        index == 0
                                            ? Icons.home_filled
                                            : index == 1
                                                ? Icons.work
                                                : Icons.location_on,
                                        color: locationController
                                                    .addressTypeIndex ==
                                                index
                                            ? AppColors.mainColor
                                            : Theme.of(context).disabledColor,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: Dimensions.width20),
                        child: BigText(text: "Địa chỉ nhận hàng")),
                    SizedBox(
                      height: 5,
                    ),
                    AppTextField(
                        textController: _addressController,
                        labelText: "Địa chỉ",
                        icon: Icons.location_on),
                    SizedBox(
                      height: 5,
                    ),
                    AppTextField(
                        textController: _contactPersonName,
                        labelText: "Tên",
                        icon: Icons.person),
                    SizedBox(
                      height: 5,
                    ),
                    AppTextField(
                        textController: _contactPersonNumber,
                        labelText: "Số điện thoại",
                        icon: Icons.phone),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimensions.height20 * 8,
                padding: EdgeInsets.only(
                    top: Dimensions.height30,
                    bottom: Dimensions.height30,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20 * 2),
                        topRight: Radius.circular(Dimensions.radius20 * 2))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AddressModel _addressModel = AddressModel(
                          addressType: locationController.addressTypeList[
                              locationController.addressTypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                          latitude:
                              locationController.position.latitude.toString(),
                          longitude:
                              locationController.position.longitude.toString(),
                        );
                        locationController
                            .addAddress(_addressModel)
                            .then((response) {
                          if (response.isSuccess) {
                            Get.snackbar("Address", "Added Successfully");
                            Get.toNamed(RouteHelper.getInitial());
                          } else {
                            Get.snackbar("Address", "Couldn't save address");
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        child: BigText(
                          text: "Save Address",
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
