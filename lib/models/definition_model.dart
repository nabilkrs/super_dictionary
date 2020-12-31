
class Definitions {
  String definition;
  String example;
  List<String> synonyms;

  Definitions({this.definition, this.example, this.synonyms});

  Definitions.fromJson(Map<String, dynamic> json) {
    definition = json['definition'];
    example = json['example'];
    synonyms = json['synonyms']!=null?json['synonyms'].cast<String>():null;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['definition'] = this.definition;
    data['example'] = this.example;
    data['synonyms'] = this.synonyms;
    return data;
  }
}
