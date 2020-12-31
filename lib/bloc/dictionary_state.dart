part of 'dictionary_bloc.dart';

@immutable
abstract class DictionaryState {}

class DictionaryInitial extends DictionaryState {}

class DictionaryLoading extends DictionaryState {}

class DictionaryLoaded extends DictionaryState {
final Dictionary dic;
DictionaryLoaded(this.dic);
}

class DictionaryError extends DictionaryState {
  final String message;
  DictionaryError(this.message);
}
