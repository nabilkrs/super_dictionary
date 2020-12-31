import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:super_dictionary/models/dictionary_model.dart';
import 'package:super_dictionary/repository/dictionary_repository.dart';

part 'dictionary_event.dart';
part 'dictionary_state.dart';

class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState> {
  final DictionaryRepository repository;
  DictionaryBloc(this.repository) : super(DictionaryInitial());

  @override
  Stream<DictionaryState> mapEventToState(
    DictionaryEvent event,
  ) async* {
    if (event is DictionaryEvent){
      yield DictionaryLoading();
      try{
        final Dictionary meaning = await repository.getMeaning();
        yield DictionaryLoaded(meaning);



      }
      catch(e){
        yield DictionaryError(e.toString());

      }

    }
  }
}
