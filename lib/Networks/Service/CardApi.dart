import 'package:dio/dio.dart' hide Headers;
import 'package:logger/logger.dart';
import 'package:retrofit/retrofit.dart';
part 'CardApi.g.dart';
@RestApi(baseUrl: 'https://staging.mannkibaatprogram.in')
abstract class CardApi {
  factory CardApi (Dio dio) = _CardApi;
  @GET('/api/event_tracker/get_events')
  Future<HttpResponse> getEvents(@Header('Authorization') String token);
}