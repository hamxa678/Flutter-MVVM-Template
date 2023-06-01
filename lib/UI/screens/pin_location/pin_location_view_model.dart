import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:flutter_mvvm_template/core/others/base_view_model.dart';
import 'package:flutter_mvvm_template/core/services/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PinLocationViewModel extends BaseViewModel {
  late GoogleMapController controller;
  late CameraPosition initialCameraPosition;
  // ignore: prefer_typing_uninitialized_variables
  var currentLocationIcon;
  Set<Marker> markers = <Marker>{};
  late LatLng markerPosition;
  final _locationService = LocationService();
  LatLng? currentLoc;
  LatLng? selectedLocation;

  PinLocationViewModel() {
    init();
  }

  init() async {
    setState(ViewState.busy);
    markerPosition = const LatLng(34.045253, 71.593056); // Peshawar pin
    initialCameraPosition = CameraPosition(target: markerPosition, zoom: 10);
    _setupCustomMarkers();
    setState(ViewState.idle);
  }

  _setupCustomMarkers() async {
    currentLocationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        'assets/static_images/current-location.png');
  }

  addMarker(LatLng markerLocation) {
    selectedLocation = markerLocation;
    markers.clear();
    markers.add(
      Marker(
        position: markerLocation,
        markerId: const MarkerId('pin_location'),
        infoWindow: const InfoWindow(title: 'Your selected location'),
      ),
    );
    notifyListeners();
  }

  getAndAnimateToCurrentLocation() async {
    final loc = await _locationService.getCurrentLocation();
    if (loc != null) {
      currentLoc = LatLng(loc.latitude, loc.longitude);
      markers.add(Marker(
        markerId: const MarkerId('current_location'),
        position: currentLoc!,
        infoWindow: const InfoWindow(title: 'Current Location'),
        icon: currentLocationIcon,
      ));
      notifyListeners();
      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: currentLoc!, zoom: 10)));
    }
  }

  // launchUrl() async {
  //   if (await canLaunch((_googleMapsUrl))) {
  //     debugPrint('$_googleMapsUrl');
  //     await launch(_googleMapsUrl);
  //   } else {
  //     print('Exception @launchUrl: Can\'t launch $_googleMapsUrl');
  //   }
  // }
}
