import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oba_app/widgets/main_drawer.dart';

class ShopsMap extends StatelessWidget {
  static const routeName = '/shops-map';

  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('L2'),
      position: LatLng(
        49.8428909,
        24.0192313,
      ),
    ),
    Marker(
      markerId: MarkerId('L1'),
      position: LatLng(
        49.8362614,
        24.0069265,
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Наші магазини'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              49.8388909,
              24.0122313,
            ),
            zoom: 15,
          ),
          markers: _markers,
        ),
      ),
    );
  }
}
