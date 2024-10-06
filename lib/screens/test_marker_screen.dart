import 'package:flutter/material.dart';
import 'package:maps_app/markers/markers.dart';

class TestMarkerScreen extends StatelessWidget {
  const TestMarkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.red,
          width: 350.0,
          height: 150.0,
          child: CustomPaint(
            painter: EndtMarkerPainter(
              kilometers: 55,
              destination: 'Roosters Rest & Snack Bar',
            ),
          ),
        ),
      ),
    );
  }
}
