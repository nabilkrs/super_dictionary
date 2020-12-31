import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_dictionary/bloc/dictionary_bloc.dart';
import 'package:super_dictionary/repository/dictionary_repository.dart';

import 'home.dart';


main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:BlocProvider(
        create: (context) => DictionaryBloc(DictionaryRepositoryImplementation()),
        child: Home(),
      ),
      
    );
  }
}