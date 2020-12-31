import 'phonetics_model.dart';

import 'meanings_model.dart';

class Dictionary {
  String word;
  Phonetics phonetics;
  Meanings meanings;

  Dictionary({this.word, this.phonetics, this.meanings});

  Dictionary.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    
    if (json['phonetics']!=null){
            phonetics = new Phonetics.fromJson(json['phonetics'][0]);
    }
    if (json['meanings']!=null){
    meanings = new Meanings.fromJson(json['meanings'][0]);
    }
   
     
  
    
      
      //meanings.partOfSpeech="hello";
    
  }
/*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['word'] = this.word;
    if (this.phonetics != null) {
      data['phonetics'] = this.phonetics.map((v) => v.toJson()).toList();
    }
    if (this.meanings != null) {
      data['meanings'] = this.meanings.map((v) => v.toJson()).toList();
    }
    return data;
  }*/
}




