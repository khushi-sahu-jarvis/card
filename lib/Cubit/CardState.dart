import 'package:project/Networks/Model/CardModel.dart';

abstract class CardState{}
class InitialState extends CardState{}
class LoadingState extends CardState{}
class FetchState extends CardState{
  final CardModel model;
  FetchState(this.model);
}
class CardErrorState extends CardState {
  final String error;

  CardErrorState(this.error);
}