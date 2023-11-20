import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SSimepleMap extends StatefulWidget {
  @override
  _SSimepleMapState createState() => _SSimepleMapState();
}

class _SSimepleMapState extends State<SSimepleMap> {
  LatLng _initialDestination = LatLng(18.5808, 73.9787);
  LatLng _finalDestination = LatLng(18.5285, 73.8744);
  LatLng _busLocation = LatLng(18.5808, 73.9787); // Sample bus location

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

    _markers.add(
      Marker(
        markerId: MarkerId('bus_location'),
        position: _busLocation,
        infoWindow: InfoWindow(title: 'Live Bus Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );

    // Add 4-5 bus icons near the initial destination
    for (int i = 1; i <= 5; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId('bus_$i'),
          position: LatLng(
            _initialDestination.latitude + 0.002 * i,
            _initialDestination.longitude - 0.002 * i,
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          infoWindow: InfoWindow(title: 'Bus $i'),
        ),
      );
    }
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
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          AppBar(
            title: const Text(
              "Live Bus Tracking",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.blueGrey,
            elevation: 0.0,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              child: GoogleMap(
                initialCameraPosition: _kInitialPosition,
                markers: _markers,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
