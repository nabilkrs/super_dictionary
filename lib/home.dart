import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity/connectivity.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'bloc/dictionary_bloc.dart';
import 'dart:convert' show utf8;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<String> flags=["US","FR","ES","DE"];
  int fl = 1;
  String flag;
  String search, enter;
  String errorempty;
  String errorword;
  String nature, def, exemple, msgnotfound, msgexemple, pren, loading, invalid,errornetwork,problem;

  final wordController = TextEditingController();
  void saveword(String ch) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString('word', ch);
  }

  String abcd;
  void getword() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      abcd = pref.getString('word');
    });
  }

  Icon icon = Icon(
    Icons.play_arrow_rounded,
    color: Colors.green[600],
    size: 40,
  );
  void play(String url) async {
    setState(() {
      icon=Icon(
    Icons.play_arrow_rounded,
    color: Colors.white,
    size: 40,
  );
    });

    AudioPlayer audioPlayer = AudioPlayer();
    AudioPlayer.logEnabled = true;
    await audioPlayer.play(url);
    setState(() {
      icon=Icon(
    Icons.play_arrow_rounded,
    color: Colors.green[600],
    size: 40,
  );
    });
  }

  void flagGetter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      fl = prefs.getInt('lang') ?? 1;
    });
    switch (fl) {
      case 1:
        setState(() {
          flag = "US.png";
          search = "Search";
          enter = "Enter a word";
          errorempty = "Word error";
          errorword = "Only one word allowed";


          nature = "Nature";
          def = "Definition";
          exemple = "Example";
          pren = "pronunciation";
          msgnotfound = "Sorry we couldn't find the word";
          msgexemple = "Exemple Unavailable";
          loading = "Loading";
          invalid = "Invalid word";
          errornetwork="Couldn't search for ${wordController.text}. Make sure your phone has an Internet connection and try again.";
          problem="Network Error";
        });
        break;

      case 2:
        setState(() {
          flag = "FR.png";
          search = "Rechercher";
          enter = "Enter une mot";
          errorempty = "erreur de mot";
          errorword = "Un seul mot autorisé";

          nature = "Nature";
          def = "Definition";
          exemple = "Exemple";
          pren = "prononciation";
          msgnotfound = "Désolé, nous n'avons pas trouvé le mot";
          msgexemple = "Exemple non disponible";
          loading = "Chargement";
          invalid = "Mot invalide";
          errornetwork="Impossible de rechercher ${wordController.text}. Assurez-vous que votre téléphone dispose d'une connexion Internet et réessayez.";
          problem="Erreur réseau";
        });
        break;
      case 3:
        setState(() {
          flag = "ES.jpg";
          search = "Buscar";
          enter = "Ingrese una palabra";
          errorempty = "Error de palabra";
          errorword = "solo una palabra permitida";

          nature = "Naturaleza";
          def = "Definición";
          exemple = "Ejemplo";
          pren = "pronunciación";
          msgnotfound = "Lo siento, no pudimos encontrar la palabra";
          msgexemple = "Ejemplo no disponible";
          loading = "Cargando";
          invalid = "Palabra inválida";
          errornetwork="No se pudo buscar ${wordController.text}. Asegúrese de que su teléfono tenga conexión a Internet y vuelva a intentarlo.";
problem="Error de red";
        });
        break;
      case 4:
        setState(() {
          flag = "DE.png";
          search = "Suche";
          enter = "Geben Sie ein Wort ein";
          errorempty = "Wortfehler";
          errorword = "nur ein Wort erlaubt";

          nature = "Natur";
          def = "Definition";
          exemple = "Beispiel";
          pren = "Aussprache";
          msgnotfound = "Entschuldigung, wir konnten das Wort nicht finden";
          msgexemple = "Beispiel nicht verfügbar";
          loading = "Wird geladen";
          invalid = "Ungültiges Wort";
          errornetwork="Es konnte nicht nach ${wordController.text} gesucht werden. Stellen Sie sicher, dass Ihr Telefon über eine Internetverbindung verfügt, und versuchen Sie es erneut.";
          problem="Netzwerkfehler";
        });
        break;
      default:
        setState(() {
          flag = "US";
          search = "Search";
          enter = "Enter a word";
          errorempty = "The above field cannot be empty";
          errorword = "You have to search only on one word";
          problem="Netzwerkfehler";
        });
        break;
    }
  }

  ScrollController scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    DictionaryBloc dicbloc = BlocProvider.of<DictionaryBloc>(context);
    flagGetter();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title:
            Text("Super Dictionary", style: TextStyle(fontFamily: 'Tajawal')),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.translate),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialog();
                    });
              })
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0,top:10,bottom:10),
          child: Container(
            
            decoration: BoxDecoration(border: Border.all(width: 2,color:Colors.black),
            color:Colors.transparent,
            image:DecorationImage(image: AssetImage("images/" + flag))
            
            
            ),
            ),
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Stack(
          children: [
            Container(
              height: 280,
              decoration: BoxDecoration(
                  color: Colors.red[700],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width),
                  Container(
                      height: 60,
                      width: 240,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 4,
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 6),
                        child: TextFormField(
                          controller: wordController,
                          decoration: InputDecoration(
                            suffixIcon: wordController.text.isEmpty
                                ? null
                                : IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => wordController.text = "",
                                  ),
                            hintText: "$enter",
                            hintStyle: TextStyle(fontFamily: 'Tajawal'),
                            border: InputBorder.none,
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      height: 60,
                      width: 240,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 4,
                            )
                          ]),
                      child: InkWell(
                        onTap: () async {
                          var result = await Connectivity().checkConnectivity();
                          if (wordController.text.isEmpty) {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red[600],
                                behavior: SnackBarBehavior.floating,
                                content: Row(
                                  children: [
                                    Icon(Icons.error),
                                    SizedBox(width: 30),
                                    Text("$errorempty"),
                                  ],
                                )));
                          } else if (wordController.text.indexOf(' ') != -1) {
                            _scaffoldKey.currentState.showSnackBar(new SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red[600],
                                behavior: SnackBarBehavior.floating,
                                content: Row(
                                  children: [
                                    Icon(Icons.error),
                                    SizedBox(width: 30),
                                    Text("$errorword"),
                                  ],
                                )));
                          } else if (result == ConnectivityResult.none) {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              title: problem,
                              text:errornetwork,
                            );
                          } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                              .hasMatch(wordController.text)) {
                            _scaffoldKey.currentState.showSnackBar(new SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red[600],
                                behavior: SnackBarBehavior.floating,
                                content: Row(
                                  children: [
                                    Icon(Icons.error),
                                    SizedBox(width: 30),
                                    Text("$invalid"),
                                  ],
                                )));
                          } else {
                            saveword(wordController.text);
                            dicbloc.add(GetMeaning());

                            scrollController.animateTo(230,
                                duration: Duration(seconds: 1),
                                curve: Curves.ease);
                          }
                          // scrollController.jumpTo(90);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //   SizedBox(width:100,),
                            SizedBox(
                              width: 1,
                            ),
                            SizedBox(
                              width: 1,
                            ),

                            Icon(
                              Icons.search,
                              color: Colors.red[700],
                              size: 25,
                            ),

                            Text(
                              "$search",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red[700],
                                  fontFamily: 'Tajawal'),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            SizedBox(
                              width: 1,
                            ),
                          ],
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 150),
                      width: MediaQuery.of(context).size.width - 10,
                      height: 350,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: BlocBuilder<DictionaryBloc, DictionaryState>(
                          builder: (context, state) {
                            if (state is DictionaryLoading) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(),
                                  Text("$loading...",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.indigo[700],
                                          fontFamily: 'Tajawal',
                                          fontWeight: FontWeight.w600)),
                                ],
                              );
                            } else if (state is DictionaryLoaded) {
                              if (state.dic.phonetics.audio != null) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: "$nature : ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.red[700],
                                            fontFamily: 'Tajawal',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text: state.dic.meanings.partOfSpeech,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Tajawal',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ])),
                                   
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            "$pren : ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.red[700],
                                                fontFamily: 'Tajawal',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        IconButton(
                                            icon: icon,
                                            onPressed: () {
                                              play(state.dic.phonetics.audio);
                                            })
                                      ],
                                    ),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: "$def : ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.red[700],
                                            fontFamily: 'Tajawal',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text: state.dic.meanings.definitions
                                            .definition,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Tajawal',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ])),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: "$exemple : ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.red[700],
                                            fontFamily: 'Tajawal',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text: state.dic.meanings.definitions
                                                .example ??
                                            msgexemple,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Tajawal',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ]))
                                  ],
                                );
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: "$nature : ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.red[700],
                                            fontFamily: 'Tajawal',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text: state.dic.meanings.partOfSpeech,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Tajawal',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ])),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: "$def : ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.red[700],
                                            fontFamily: 'Tajawal',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text: state.dic.meanings.definitions
                                            .definition,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Tajawal',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ])),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: "$exemple : ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.red[700],
                                            fontFamily: 'Tajawal',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text: state.dic.meanings.definitions
                                                .example ??
                                            msgexemple,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Tajawal',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ]))
                                  ],
                                );
                              }
                            } else if (state is DictionaryError) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(),
                                  Text(
                                    msgnotfound,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.red[700],
                                        fontFamily: 'Tajawal',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              );
                            }
                            return SizedBox();
                          },
                        ),
                      )),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  int x = 0;
  void stocker(int x) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('lang', x);
  }

  void getter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    setState(() {
      x = prefs.getInt('lang') ?? 1;
    });
  }

  dialogContent(BuildContext context, int v) {
    getter();

    // x = v;
    return SingleChildScrollView(
      child: Container(
        height: 300,
        decoration: new BoxDecoration(
          color: Colors.red[700],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
        
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Choose Language",
                style: GoogleFonts.tajawal(
                    textStyle: TextStyle(fontSize: 25, color: Colors.white)),
              ),
            ),
            RadioListTile(
              title: Text("English",
                  style: GoogleFonts.tajawal(
                      textStyle: TextStyle(color: Colors.white))),
              activeColor: Colors.white,
              value: 1,
              groupValue: x,
              onChanged: (value) {
                setState(() {
                  x = value;
                });
                stocker(value);

                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: Text("Français",
                  style: GoogleFonts.tajawal(
                      textStyle: TextStyle(color: Colors.white))),
              activeColor: Colors.white,
              value: 2,
              groupValue: x,
              onChanged: (value) {
              
                setState(() {
                  x = value;
                });
                stocker(value);
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: Text("Española",
                  style: GoogleFonts.tajawal(
                      textStyle: TextStyle(color: Colors.white))),
              activeColor: Colors.white,
              value: 3,
              groupValue: x,
              onChanged: (value) {
              
                setState(() {
                  x = value;
                });
                stocker(value);
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: Text("Deutsche",
                  style: GoogleFonts.tajawal(
                      textStyle: TextStyle(color: Colors.white))),
              activeColor: Colors.white,
              value: 4,
              groupValue: x,
              onChanged: (value) {
                
                setState(() {
                  x = value;
                });
                stocker(value);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  int v;

  Future<int> getter1(int v) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    v = prefs.getInt('lang');

    return v;
  }

  @override
  void initState() {
    super.initState();
    getter();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, v),
    );
  }
}

/* The following ArgumentError was thrown building Home(dirty, state: _HomeState#94d8a):
Invalid argument(s)

The relevant error-causing widget was
Home
 */
