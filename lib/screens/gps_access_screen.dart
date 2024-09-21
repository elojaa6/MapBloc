import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/gps/gps_bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            return !state.isGpsEnabled
                ? const _EnabledGpsMessage()
                : const _AccesButton();
          },
        ),
      ),
    );
  }
}

class _AccesButton extends StatelessWidget {
  const _AccesButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Es necesario el acceso al GPS'),
        MaterialButton(
          color: Colors.black,
          shape: const StadiumBorder(),
          elevation: 0,
          splashColor: Colors.transparent,
          onPressed: () {
            final gpsBloc = BlocProvider.of<GpsBloc>(context);
            gpsBloc.askGpsAcess();
          },
          child: const Text(
            'Solicitar Acceso',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _EnabledGpsMessage extends StatelessWidget {
  const _EnabledGpsMessage();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Debe de habilitar el GPS',
      style: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
