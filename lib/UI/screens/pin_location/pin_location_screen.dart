import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/screens/pin_location/pin_location_view_model.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PinLocationScreen extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();

  PinLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PinLocationViewModel(),
        child: Consumer<PinLocationViewModel>(builder: (context, model, child) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              // backgroundColor: baseColor,
              onPressed: () {
                model.getAndAnimateToCurrentLocation();
              },
              child: const Icon(Icons.gps_fixed),
            ),
            appBar: AppBar(
              title: const Text('Active Location'),
              // actions: <Widget>[
              //   Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: Image.asset(
              //       '$image/logo2.png',
              //       height: 34.h,
              //       width: 34.w,
              //     ),
              //   )
              // ],
            ),
            body: model.state == ViewState.busy
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      GoogleMap(
                        onTap: (location) {
                          model.addMarker(location);
                        },
                        mapType: MapType.normal,
                        initialCameraPosition: model.initialCameraPosition,
                        onMapCreated: (GoogleMapController controller) {
                          model.controller = controller;
                          _controller.complete(controller);
                        },
                        markers: model.markers,
                      ),
                      if (model.selectedLocation != null)
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              child: const Text('Confirm Location'),
                              onPressed: () {
                                Get.back(result: model.selectedLocation);
                              },
                            ),
                          ),
                        )
                      else
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Card(
                                child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  'Tap any location on Map to select the location.'),
                            )),
                          ),
                        ),
                    ],
                  ),
          );
        }));
  }
}
