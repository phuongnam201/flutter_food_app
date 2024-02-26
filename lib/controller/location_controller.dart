import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:food_app/data/api/api_checker.dart';
import 'package:food_app/data/repository/location_repo.dart';
import 'package:food_app/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_places_flutter/model/prediction.dart';

import '../models/address_model.dart';
//import 'package:google_maps_webservice/places.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  late Position _position;
  late Position _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;

  List<AddressModel> get allAddressList => _allAddressList;
  late List<AddressModel> _allAddressList;
  final List<String> _addressTypeList = ["home", "office", "others"];

  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool _loading = false;
  bool get loading => _loading;

  Position get position => _position;
  Position get pickPosition => _pickPosition;
  // Placemark get placeMark => _placeMark;
  // Placemark get pickPlaceMark => _pickPlaceMark;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _inZone = false;
  bool get inZone => _inZone;

  bool _buttonDisable = true;
  bool get buttonDisable => _buttonDisable;

  // List<Prediction> _predictionList = [];

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1,
              altitudeAccuracy: 1,
              headingAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1,
              altitudeAccuracy: 1,
              headingAccuracy: 1);
        }

        ResponseModel _responseModel = await getZone(
            position.target.latitude.toString(),
            position.target.longitude.toString(),
            false);
        _buttonDisable = !_responseModel.isSuccess;

        if (_changeAddress) {
          //print("lat:" + position.target.latitude.toString());
          //print("lng:" + position.target.latitude.toString());
          String _address = await getAddressfromGeocode(
              LatLng(position.target.latitude, position.target.longitude));

          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
          print("address detail: " + _address);
        }
      } catch (e) {
        print(e);
      }
      _loading = false;
      update();
    }
  }

  void updatePosition2(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1,
              altitudeAccuracy: 1,
              headingAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1,
              altitudeAccuracy: 1,
              headingAccuracy: 1);
        }

        ResponseModel _responseModel = await getZone(
            position.target.latitude.toString(),
            position.target.longitude.toString(),
            false);
        _buttonDisable = !_responseModel.isSuccess;

        if (_changeAddress) {
          //print("lat:" + position.target.latitude.toString());
          //print("lng:" + position.target.latitude.toString());
          String _address = await getAddressfromGeocode(
              LatLng(position.target.latitude, position.target.longitude));

          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
          print("address detail: " + _address);
        }
      } catch (e) {
        print(e);
      }
      _loading = false;
      update();
    } else {
      _updateAddressData = true;
    }
  }

  Future<String> getAddressfromGeocode(LatLng latLng) async {
    String _address = "Unknown Location Found";
    Response response = await locationRepo.getAddressfromGeocode(latLng);
    if (response.body["status"] == 'OK') {
      _address = response.body["results"][0]['formatted_address'].toString();
      print("printing address " + _address);
    } else {
      print("Error getting the google api");
    }
    update();
    return _address;
  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    print("test get address:" + _getAddress.toString());
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print(e);
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
      print("save address to local storage");
    } else {
      print("couldn't save the address");
      responseModel = ResponseModel(false, response.statusText!);
    }

    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddress();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  // Future<Position> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   return await Geolocator.getCurrentPosition();
  // }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;

    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }

    update();
    // await Future.delayed(const Duration(seconds: 2), () {
    //   _responseModel = ResponseModel(true, "success");
    //   if (markerLoad) {
    //     _loading = false;
    //   } else {
    //     _isLoading = false;
    //   }
    //   _inZone = true;
    // });

    Response response = await locationRepo.getZone(lat, lng);
    if (response.statusCode == 200) {
      print("run on success");
      _inZone = true;
      _responseModel = ResponseModel(true, response.body["zone_id"].toString());
    } else {
      _inZone = false;
      _responseModel = ResponseModel(true, response.statusText!);
    }

    if (markerLoad) {
      _loading = false;
    } else {
      _isLoading = false;
    }
    update();
    return _responseModel;
  }

  // Future<List<Prediction>> searchLocation(
  //     BuildContext context, String text) async {
  //   if (text.isNotEmpty) {
  //     Response response = await locationRepo.searchLocation(text);
  //     if (response.statusCode == 200 && response.body['status'] == 'OK') {
  //       _predictionList = [];
  //       response.body['predictions'].forEach((prediction) =>
  //           _predictionList.add(Prediction.fromJson(prediction)));
  //     } else {
  //       ApiChecker.checkApi(response);
  //     }
  //   }
  //   return _predictionList;
  // }

  // setLocation(
  //     String placeID, String address, GoogleMapController mapController) async {
  //   _loading = true;
  //   update();
  //   PlacesDetailsResponse detail;
  //   Response response = await locationRepo.setLocation(placeID);
  //   detail = PlacesDetailsResponse.fromJson(response.body);
  //   _pickPosition = Position(
  //       latitude: detail.result.geometry!.location.lat,
  //       longitude: detail.result.geometry!.location.lng,
  //       timestamp: DateTime.now(),
  //       accuracy: 1,
  //       altitude: 1,
  //       heading: 1,
  //       speed: 1,
  //       speedAccuracy: 1,
  //       altitudeAccuracy: 1,
  //       headingAccuracy: 1);

  //   _pickPlacemark = Placemark(name: address);
  //   _changeAddress = false;
  //   if (!mapController.isNull) {
  //     mapController
  //         .animateCamera((CameraUpdate.newCameraPosition(CameraPosition(
  //             target: LatLng(
  //               detail.result.geometry!.location.lat,
  //               detail.result.geometry!.location.lng,
  //             ),
  //             zoom: 17))));
  //   }
  // }
}
