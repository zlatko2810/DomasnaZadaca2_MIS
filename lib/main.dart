import 'package:domasna2/screens/search.dart';
import 'package:domasna2/services/geolocator_service.dart';
import 'package:domasna2/services/places_service.dart';
import 'package:flutter/material.dart';
import 'package:domasna2/models/place.dart';

import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'models/place.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation(), initialData: null,),
        ProxyProvider<Position,Future<List<Place>>>(
          update: (context,position,places){
            // ignore: unnecessary_null_comparison
             {
              return placesService.getPlaces(position.latitude, position.longitude);
            }
          },
        )
      ],
      child: MaterialApp(
        title: 'Parking App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Search(),
      ),
    );
  }
}