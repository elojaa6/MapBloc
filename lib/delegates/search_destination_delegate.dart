import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  SearchDestinationDelegate() : super(searchFieldLabel: 'Buscar...');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        final result = SearchResult(cancel: true);
        close(context, result);
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = context.read<SearchBloc>();
    final proximity = context.read<LocationBloc>().state.lastKnownLocation!;

    searchBloc.getPlacesByQuery(proximity, query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final places = state.places;
        return ListView.separated(
            itemBuilder: (context, index) {
              final lugar = places[index];
              final place = lugar.properties;
              return ListTile(
                title: Text(place.name),
                subtitle: Text(place.fullAddress),
                leading: const Icon(
                  Icons.place_outlined,
                  color: Colors.black,
                ),
                onTap: () {
                  final result = SearchResult(
                    cancel: false,
                    manual: false,
                    position: LatLng(
                      place.coordinates.latitude,
                      place.coordinates.longitude,
                    ),
                    name: place.name,
                    description: place.fullAddress,
                  );

                  searchBloc.add(AddHistoryEvent(lugar));

                  close(context, result);
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: places.length);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final historyBloc = context.read<SearchBloc>().state.history;
    return ListView(
      children: [
        ListTile(
          leading: const Icon(
            Icons.location_on_outlined,
            color: Colors.black,
          ),
          title: const Text(
            'Colocar la ubicacion manualmente',
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            final result = SearchResult(cancel: false, manual: true);
            close(context, result);
          },
        ),
        ...historyBloc.map((places) {
          final place = places.properties;
          return ListTile(
            title: Text(place.name),
            subtitle: Text(place.fullAddress),
            leading: const Icon(
              Icons.place_outlined,
              color: Colors.black,
            ),
            onTap: () {
              final result = SearchResult(
                cancel: false,
                manual: false,
                position: LatLng(
                  place.coordinates.latitude,
                  place.coordinates.longitude,
                ),
                name: place.name,
                description: place.fullAddress,
              );

              close(context, result);
            },
          );
        })
      ],
    );
  }
}
