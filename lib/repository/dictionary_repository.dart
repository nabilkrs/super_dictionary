

import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_dictionary/models/dictionary_model.dart';

abstract class DictionaryRepository{

Future<Dictionary> getMeaning();

}

class DictionaryRepositoryImplementation extends DictionaryRepository{

/*
Future<String> initword()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.getString('word');
}

Future<String> initlanguageuage()async{
SharedPreferences pref=await SharedPreferences.getInstance();
int x=pref.getInt('language');
switch (x){
case 1:languageuage="en";break;
case 2:languageuage="fr";break;
case 3:languageuage="es";break;
case 4:languageuage="de";break;
default:languageuage="en";break;
}
return languageuage;
}
*/


  @override
  Future<Dictionary> getMeaning() async{
  SharedPreferences pref=await SharedPreferences.getInstance();
   String word=pref.getString('word');
   int x=pref.getInt('lang'); 
   String language="";
    switch (x){
    case 1:language="en";break;
    case 2:language="fr";break;
    case 3:language="es";break;
    case 4:language="de";break;
    default:language="en";break;
    }




    final response =await get("https://api.dictionaryapi.dev/api/v2/entries/"+language+"/"+word);
    if(response.statusCode==200){
      final result = json.decode(response.body);
      return Dictionary.fromJson(result[0]);
      }
      else
      throw Exception('Cannot find the word');

    


  }



}