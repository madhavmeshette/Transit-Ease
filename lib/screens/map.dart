import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleMap extends StatefulWidget {
  @override
  _SimpleMapState createState() => _SimpleMapState();
}

class _SimpleMapState extends State<SimpleMap> {
  LatLng _initialDestination = LatLng(18.5808, 73.9787);
  LatLng _finalDestination = LatLng(18.5285, 73.8744);

  Set<Marker> _markers = Set<Marker>();

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() {
    _markers.add(
      Marker(
        markerId: MarkerId('initial_destination'),
        position: _initialDestination,
        infoWindow: InfoWindow(title: 'Initial Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );

    _markers.add(
      Marker(
        markerId: MarkerId('final_destination'),
        position: _finalDestination,
        infoWindow: InfoWindow(title: 'Final Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  void _updateInitialDestination(LatLng position) {
    setState(() {
      _initialDestination = position;
      _markers.clear();
      _addMarkers();
    });
  }

  void _updateFinalDestination(LatLng position) {
    setState(() {
      _finalDestination = position;
      _markers.clear();
      _addMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition _kInitialPosition = CameraPosition(
      target: LatLng(18.5808, 73.9787),
      zoom: 11.0,
      tilt: 0,
      bearing: 0,
    );

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 300, // Set a fixed height or adjust as needed
            child: GoogleMap(
              initialCameraPosition: _kInitialPosition,
              markers: _markers,
            ),
          ),
        ],
      ),
    );
  }
}
