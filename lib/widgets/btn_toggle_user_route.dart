import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

class BtnToggleUserRoute extends StatelessWidget {
  const BtnToggleUserRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = context.watch<MapBloc>();
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25.0,
        child: IconButton(
          onPressed: () {
            mapBloc.add(OnToggleUserRoute());
          },
          icon: const Icon(
            Icons.more_horiz_rounded,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
