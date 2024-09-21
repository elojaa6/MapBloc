// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool folloUser;

  const MapState({
    this.isMapInitialized = false,
    this.folloUser = false,
  });

  MapState copyWith({
    bool? isMapInitialized,
    bool? folloUser,
  }) {
    return MapState(
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      folloUser: folloUser ?? this.folloUser,
    );
  }

  @override
  List<Object> get props => [
        isMapInitialized,
        folloUser,
      ];
}
