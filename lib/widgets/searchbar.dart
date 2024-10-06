import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/delegates/delegates.dart';
import 'package:maps_app/models/models.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const SizedBox()
            : FadeInDown(child: const _SearchbarBody());
      },
    );
  }
}

class _SearchbarBody extends StatelessWidget {
  const _SearchbarBody();

  void onSearchResults(BuildContext context, SearchResult result) async {
    final searchBloc = context.read<SearchBloc>();
    final locationBloc = context.read<LocationBloc>();
    final mapBloc = context.read<MapBloc>();

    if (result.manual) {
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }

    if (result.position != null) {
      final destination = await searchBloc.getCoorsStartToEnd(
          locationBloc.state.lastKnownLocation!, result.position!);
      await mapBloc.drawRoutePolyline(destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        width: double.infinity,
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(
              context: context,
              delegate: SearchDestinationDelegate(),
            );

            if (result == null) return;

            onSearchResults(context, result);
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  )
                ]),
            child: const Text(
              '¿Donde quieres ir?',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ),
      ),
    );
  }
}
