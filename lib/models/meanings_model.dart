import 'definition_model.dart';

class Meanings {
  String partOfSpeech;
  Definitions definitions;

  Meanings({this.partOfSpeech, this.definitions});

  Meanings.fromJson(Map<String, dynamic> json) {
    partOfSpeech = json['partOfSpeech'];
    definitions=new Definitions.fromJson(json['definitions'][0]);
    /*if (json['definitions'] != null) {
      definitions = new List<Definitions>();
      json['definitions'].forEach((v) {
        definitions.add(new Definitions.fromJson(v));
      });
    }*/

  }

/*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partOfSpeech'] = this.partOfSpeech;
    if (this.definitions != null) {
      data['definitions'] = this.definitions.map((v) => v.toJson()).toList();
    }
    return data;
  }*/
}