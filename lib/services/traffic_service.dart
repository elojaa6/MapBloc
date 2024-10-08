import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/models/models.dart';
import 'package:maps_app/models/places_model.dart';
import 'package:maps_app/services/services.dart';

class TrafficService {
  final Dio _dioTraffic;
  final Dio _dioPlaces;

  final String _baseTrafficUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  final String _basePlaceUrl = 'https://api.mapbox.com/search/geocode/v6';

  TrafficService()
      : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor()),
       _dioPlaces = Dio()..interceptors.add(PlacesInterceptor());

  Future<TrafficResponse> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final coorsString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';

    final url = '$_baseTrafficUrl/driving/$coorsString';

    final resp = await _dioTraffic.get(url);

    final data = TrafficResponse.fromJson(resp.data);

    return data;
  }

  Future<List<Feature>> getResultsByQuery(LatLng proximity, String query)async{
    if(query.isEmpty) return [];

    final url = '$_basePlaceUrl/forward?q=$query';

    final resp = await _dioPlaces.get(url, queryParameters: {
      'proximity': '${proximity.longitude},${proximity.latitude}',
      'limit': 7,
    });

    final placesResponse = PlacesResponse.fromJson(resp.data);

    return placesResponse.features;
  }


  Future<Feature> getInformationByCoors(LatLng coors) async{

    final url = '$_basePlaceUrl/reverse?longitude=${coors.longitude}&latitude=${coors.latitude}';
    final res = await _dioPlaces.get(url, queryParameters: {
      'limit': 1,
    });

    final placesResponse = PlacesResponse.fromJson(res.data);

    return placesResponse.features[0];
  }
}
