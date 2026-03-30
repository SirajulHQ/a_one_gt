import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/features/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class CurrentLocationPickerPage extends StatefulWidget {
  const CurrentLocationPickerPage({super.key});

  @override
  State<CurrentLocationPickerPage> createState() =>
      _CurrentLocationPickerPageState();
}

class _CurrentLocationPickerPageState extends State<CurrentLocationPickerPage> {
  final MapController _mapController = MapController();

  LatLng? _pickedLocation;
  String _addressText = "Fetching your location...";
  bool _loading = true;
  bool _mapReady = false;
  Placemark? _placemark;

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      final granted = await _ensurePermission();
      if (!granted) {
        setState(() {
          _addressText =
              "Location permission denied. Tap on map to pick manually.";
          _loading = false;
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );

      final latlng = LatLng(position.latitude, position.longitude);
      await _resolveAddress(latlng);

      if (_mapReady) {
        _mapController.move(latlng, 16);
      }
    } catch (e) {
      setState(() {
        _addressText = "Could not fetch location. Tap on map to pick manually.";
        _loading = false;
      });
    }
  }

  Future<bool> _ensurePermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return false;
    }
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  Future<void> _resolveAddress(LatLng latlng) async {
    setState(() {
      _pickedLocation = latlng;
      _loading = true;
      _addressText = "Fetching address...";
    });

    try {
      final placemarks = await placemarkFromCoordinates(
        latlng.latitude,
        latlng.longitude,
      );
      final p = placemarks.first;
      final parts = [
        p.street,
        p.subLocality,
        p.locality,
        p.administrativeArea,
        p.postalCode,
      ].where((s) => s != null && s.isNotEmpty).join(', ');

      setState(() {
        _addressText = parts.isNotEmpty ? parts : "Unknown location";
        _loading = false;
        _placemark = p;
      });
    } catch (_) {
      setState(() {
        _addressText =
            "${latlng.latitude.toStringAsFixed(5)}, ${latlng.longitude.toStringAsFixed(5)}";
        _loading = false;
        _placemark = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Use Current Location"),
      body: Stack(
        children: [
          /// FLUTTER MAP (OpenStreetMap)
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _pickedLocation ?? const LatLng(11.2588, 75.7804),
              initialZoom: 14,
              onMapReady: () => setState(() => _mapReady = true),
              onTap: (_, latlng) => _resolveAddress(latlng),
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: "com.example.a_one_gt",
              ),
              if (_pickedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _pickedLocation!,
                      width: 48,
                      height: 48,
                      child: Icon(
                        Icons.location_pin,
                        color: Appcolors.primaryGreen,
                        size: 48,
                      ),
                    ),
                  ],
                ),
            ],
          ),

          /// RE-CENTER BUTTON
          Positioned(
            right: 16,
            bottom: 220,
            child: FloatingActionButton.small(
              heroTag: "recenter",
              backgroundColor: Colors.white,
              onPressed: _fetchCurrentLocation,
              child: Icon(Icons.my_location, color: Appcolors.primaryGreen),
            ),
          ),

          /// BOTTOM ADDRESS CARD
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Selected Location",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Appcolors.gradientColor2,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _loading
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  LinearProgressIndicator(
                                    color: Appcolors.primaryGreen,
                                    backgroundColor: Colors.grey.shade200,
                                  ),
                                ],
                              )
                            : Text(
                                _addressText,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  height: 1.4,
                                ),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          Appcolors.gradientColor1,
                          Appcolors.gradientColor2,
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: _pickedLocation == null || _loading
                          ? null
                          : () => Navigator.pop(context, {
                              'address': _addressText,
                              'street':
                                  [_placemark?.street, _placemark?.subLocality]
                                      .where((s) => s != null && s.isNotEmpty)
                                      .join(', '),
                              'city': _placemark?.locality ?? '',
                              'state': _placemark?.administrativeArea ?? '',
                              'pincode': _placemark?.postalCode ?? '',
                              'latlng': _pickedLocation,
                            }),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        disabledBackgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Confirm Location",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
