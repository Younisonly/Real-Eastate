
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class ViewMap extends StatefulWidget {
  final LatLng Location;

   ViewMap({ required this.Location});

  @override
  State<ViewMap> createState() => _ViewMapState();
}

class _ViewMapState extends State<ViewMap> {

  var Location;

  void initState() {
    super.initState();
    Location = widget.Location;
  }

  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('عرض الموقع'),
        actions: [
          ElevatedButton(
            onPressed: () {
              mapController.move(
                  LatLng(widget.Location.latitude,widget.Location.longitude), 14);
            },
            child: Image.asset(
              'assets/images/compass.png',
              height: 35,
              width: 35,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(51.509364, -0.128928),
              initialZoom: 9.2,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}