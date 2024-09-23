// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool displayManualMarker;

  const SearchState({
    this.displayManualMarker = false,
  });

  @override
  List<Object> get props => [displayManualMarker];

  SearchState copyWith({
    bool? displayManualMarker,
  }) {
    return SearchState(
      displayManualMarker: displayManualMarker ?? this.displayManualMarker,
    );
  }
}
