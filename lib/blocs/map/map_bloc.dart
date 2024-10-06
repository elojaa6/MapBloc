import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/models/models.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({
    required this.locationBloc,
  }) : super(const MapState()) {
    on<OnMapInitialzedEvent>(_onInitMap);

    on<OnStartFollowingUserEvent>(_onStartFollowingUser);

    on<OnStopFollowingUserEvent>(
        (event, emit) => emit(state.copyWith(isFollowingUser: false)));

    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);

    on<OnToggleUserRoute>(
      (event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)),
    );

    on<DisplayPolylinesEvent>((event, emit) {
      emit(state.copyWith(
        polylines: event.polylines,
        markers: event.markers,
      ));
    });

    locationStateSubscription = locationBloc.stream.listen(
      (locationState) {
        if (locationState.lastKnownLocation != null) {
          add(UpdateUserPolylineEvent(locationState.myLocationsHistory));
        }

        if (!state.isFollowingUser) return;
        if (locationState.lastKnownLocation == null) return;

        moveCamera(locationState.lastKnownLocation!);
      },
    );
  }

  void _onInitMap(OnMapInitialzedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;

    emit(state.copyWith(isMapInitialized: true));
  }

  void _onStartFollowingUser(
      OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowingUser: true));
    if (locationBloc.state.lastKnownLocation == null) return;
    moveCamera(locationBloc.state.lastKnownLocation!);
  }

  void _onPolylineNewPoint(
      UpdateUserPolylineEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocations,
    );

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  Future drawRoutePolyline(RouteDestination destination) async {
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );

    double kms = destination.distance / 1000;
    kms = (kms * 100).floorToDouble();
    kms /= 100;

    //double tripDuration = (destination.duration / 60).floorToDouble();
    int tripDuration = (destination.duration / 60).toInt();

    // final startMaker = await getAssetImageMarker();
    // final endMaker = await getNetworkImageMarker();

    final startMaker = await getStartCustomMarker(tripDuration, 'Mi ubicación');
    final endMaker = await getEndCustomMarker(
        kms.toInt(), destination.endPlace.properties.namePreferred);

    final startMarker = Marker(
      markerId: const MarkerId('start'),
      position: destination.points.first,
      icon: startMaker,
      // infoWindow: InfoWindow(
      // title: 'Inicio',
      // snippet: 'Kms $kms, duracion $tripDuration min',
      // ),
    );

    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      icon: endMaker,
      // infoWindow: InfoWindow(
      //   title: destination.endPlace.properties.namePreferred,
      //   snippet: destination.endPlace.properties.fullAddress,
      // ),
    );

    final curretPolylines = Map<String, Polyline>.from(state.polylines);
    curretPolylines['route'] = myRoute;

    final curretMarkers = Map<String, Marker>.from(state.markers);
    curretMarkers['start'] = startMarker;
    curretMarkers['end'] = endMarker;

    add(DisplayPolylinesEvent(
        polylines: curretPolylines, markers: curretMarkers));

    //await Future.delayed(const Duration(milliseconds: 300));
    //_mapController?.showMarkerInfoWindow(startMarker.markerId);
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
