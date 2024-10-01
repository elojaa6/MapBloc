import 'package:dio/dio.dart';

const accessToken = 'pk.eyJ1IjoiZWxvamFhNiIsImEiOiJjbTFlZWg1dmsxajVnMmxxM2Z3Znd0d2szIn0.umU729YevMoxdeGqLT7JnQ';

class TrafficInterceptor extends Interceptor{
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'alternatives' : true,
      'geometries' : 'polyline6',
      'overview' : 'simplified',
      'steps' : false,
      'access_token' : accessToken
    });
    super.onRequest(options, handler);
  }
}