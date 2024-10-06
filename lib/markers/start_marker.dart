import 'package:flutter/material.dart';

class StartMarkerPainter extends CustomPainter {
  final int minutes;
  final String destination;

  StartMarkerPainter({
    required this.minutes,
    required this.destination,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final blackPaint = Paint()..color = Colors.black;

    final whitePaint = Paint()..color = Colors.white;

    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;

    //* Circulo negro
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height - circleBlackRadius),
      circleBlackRadius,
      blackPaint,
    );

    //* Circulo blanco
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height - circleBlackRadius),
      circleWhiteRadius,
      whitePaint,
    );

    //* Dibujar caja Blanca
    final path = Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);

    //* Sombra
    canvas.drawShadow(path, Colors.black, 10.0, false);

    //* Caja Blanca
    canvas.drawPath(path, whitePaint);

    //* Caja Negra
    const blackBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackBox, blackPaint);

    //* Textos
    //* Minutos
    final textSpan = TextSpan(
      style: const TextStyle(
          color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w400),
      text: '$minutes',
    );

    final minutesPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70,
        maxWidth: 70,
      );

    minutesPainter.paint(canvas, const Offset(40, 35));

    //* Palabra MIN
    const minutesText = TextSpan(
      style: TextStyle(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w300),
      text: 'Min',
    );

    final minutesMinPainter = TextPainter(
      text: minutesText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70,
        maxWidth: 70,
      );

    minutesMinPainter.paint(canvas, const Offset(40, 68));

    //* Descripcion

    final locationText = TextSpan(
      style: const TextStyle(
          color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w300),
      text: destination,
    );

    final locationPainter = TextPainter(
      maxLines: 2,
      ellipsis: '...',
      text: locationText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: size.width - 90,
        maxWidth: size.width - 90,
      );

    double offsetY = (destination.length > 20) ? 35.0 : 48.0;

    locationPainter.paint(canvas, Offset(40, offsetY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
