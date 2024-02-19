import 'package:food_app/data/repository/location_repo.dart';
import 'package:food_app/models/address_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  bool _loading = false;
  late Position _position;
  late Position _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  List<String> addressTypeList = ["home", "office", "others"];
  int _addressTypeIndex = 0;
  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  late GoogleMapController _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

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

        if (_changeAddress) {
          print("lat:" + position.target.latitude.toString());
          print("lng:" + position.target.latitude.toString());
          String _address = await getAddressfromGeocode(
              LatLng(position.target.latitude, position.target.longitude));

          //print("address detail: " + _address);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String> getAddressfromGeocode(LatLng latlng) async {
    String _address = "Unknow location found";
    Response response = await locationRepo.getAddressfromGeocode(latlng);
    //print(response.body.toString());

    if (response.body["status"] == 'OK') {
      //print("succes from geocode");
      _address = response.body["results"][0]['formatted_address'].toString();
      //print("address from location_controller:" + _address);
    } else {
      print("error getting the google api");
    }
    //print(_address);
    return _address;
  }
}
