import 'package:dio/dio.dart';

class PlacesInterceptor extends Interceptor {
  final accessToken =
      'pk.eyJ1IjoiZWxvamFhNiIsImEiOiJjbTFlZWg1dmsxajVnMmxxM2Z3Znd0d2szIn0.umU729YevMoxdeGqLT7JnQ';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'access_token': accessToken,
      'language': 'es',
      'limit': 7,
    });
    super.onRequest(options, handler);
  }
}
