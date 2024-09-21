// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnownLocation;
  final List<LatLng> myLocationsHistory;

  const LocationState({
    this.followingUser = false,
    this.lastKnownLocation,
    myLocationsHistory,
  }) : myLocationsHistory = myLocationsHistory ?? const [];

  @override
  List<Object?> get props => [
        followingUser,
        lastKnownLocation,
        myLocationsHistory,
      ];

  LocationState copyWith({
    bool? followingUser,
    LatLng? lastKnownLocation,
    List<LatLng>? myLocationsHistory,
  }) {
    return LocationState(
      followingUser: followingUser ?? this.followingUser,
      lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
      myLocationsHistory: myLocationsHistory ?? this.myLocationsHistory,
    );
  }
}
