import 'package:flutter/material.dart';

class EndtMarkerPainter extends CustomPainter {
  final int kilometers;
  final String destination;

  EndtMarkerPainter({
    required this.kilometers,
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
    path.moveTo(10, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(10, 100);

    //* Sombra
    canvas.drawShadow(path, Colors.black, 10.0, false);

    //* Caja Blanca
    canvas.drawPath(path, whitePaint);

    //* Caja Negra
    const blackBox = Rect.fromLTWH(10, 20, 70, 80);
    canvas.drawRect(blackBox, blackPaint);

    //* Textos
    //* Minutos
    final textSpan = TextSpan(
      style: const TextStyle(
          color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w400),
      text: '$kilometers',
    );

    final kilometersPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70,
        maxWidth: 70,
      );

    kilometersPainter.paint(canvas, const Offset(10, 35));

    //* Palabra MIN
    const kilometersText = TextSpan(
      style: TextStyle(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w300),
      text: 'Kms',
    );

    final kilometersMinPainter = TextPainter(
      text: kilometersText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70,
        maxWidth: 70,
      );

    kilometersMinPainter.paint(canvas, const Offset(10, 68));

    //* Descripcion

    final locationText = TextSpan(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w300,
      ),
      text: destination,
    );

    final locationPainter = TextPainter(
      maxLines: 2,
      ellipsis: '...',
      text: locationText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    )..layout(
        minWidth: size.width - 90,
        maxWidth: size.width - 90,
      );

    double offsetY = (destination.length > 25) ? 35.0 : 48.0;

    locationPainter.paint(canvas, Offset(90, offsetY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
