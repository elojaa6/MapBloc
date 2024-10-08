import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

class BtnFollowUser extends StatelessWidget {
  const BtnFollowUser({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = context.watch<MapBloc>();
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25.0,
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                mapBloc.add(OnStartFollowingUserEvent());
              },
              icon: Icon(
                state.isFollowingUser
                    ? Icons.directions_run_rounded
                    : Icons.hail_rounded,
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }
}
