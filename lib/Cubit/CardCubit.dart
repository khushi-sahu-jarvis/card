import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:project/Logger.dart';
import 'package:project/Networks/Model/CardModel.dart';

import '../Networks/Service/CardApi.dart';
import 'CardState.dart';

class CardCubit extends Cubit<CardState> {
CardCubit() : super(InitialState());
final api = CardApi(Dio(BaseOptions(
    contentType: 'application/json', validateStatus: ((status) => true))));

Future getEvents() async {
  try {
    emit(LoadingState());
    String token =
        "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.1aBzmXruUAVV7ancpI1gu6GhOSso9xUqONf2DZ9ICmA";
    final res = await api.getEvents('Bearer $token');

    if (res.response.statusCode == 200) {
      CardModel modal = CardModel.fromJson(res.data);
      emit(FetchState(modal));
      Logger log=Logger(
         //printer: SimpleLogPrinter(),
      );
      log.d(res.response.statusCode);
    } else {
      Map<String, dynamic>? msg = res.data;
      emit(CardErrorState(msg?['error'] ?? ''));
    }
  } catch (e) {
    emit(CardErrorState(e.toString()));
  }
}
}
