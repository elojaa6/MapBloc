import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show BitmapDescriptor;

Future<BitmapDescriptor> getAssetImageMarker() async {
  return BitmapDescriptor.asset(
    const ImageConfiguration(devicePixelRatio: 2.5, size: Size(48, 48)),
    'assets/custompin.png',
  );
}

Future<BitmapDescriptor> getNetworkImageMarker() async {
  final res = await Dio().get(
      'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
      options: Options(
        responseType: ResponseType.bytes,
      ));

  // return BitmapDescriptor.bytes(res.data);

  final imageCodec = await ui.instantiateImageCodec(res.data,
      targetHeight: 50, targetWidth: 50);

  final frame = await imageCodec.getNextFrame();

  final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);

  if (data == null) return await getAssetImageMarker();

  return BitmapDescriptor.bytes(data.buffer.asUint8List());
}
