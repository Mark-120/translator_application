import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({super.key});

  @override
  State<LanguageTranslationPage> createState() =>
      _LanguageTranslationPageState();
}

class _LanguageTranslationPageState extends State<LanguageTranslationPage> {
  var languages = ['Russian', 'English'];
  String originLanguage = 'From';
  String destinationLanguage = 'To';
  String output = '';
  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();

    if (src == '--' || dest == '--') {
      setState(() {
        output = 'Failed to translate';
      });
    } 
    else if (input.isEmpty) {
      setState(() {
        output = 'Enter your text to translate';
      });
    }
    else {
      Translation translation =
          await translator.translate(input, from: src, to: dest);
      setState(() {
        output = translation.text.toString();
      });
    }
  }

  String getLanguageCode(String language) {
    if (language == 'English') {
      return 'en';
    } else if (language == 'Russian') {
      return 'ru';
    } else {
      return '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(98, 63, 56, 254),
      appBar: AppBar(
        title: Text(
          'Language Translator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  items: languages.map((language) {
                    return DropdownMenuItem(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      originLanguage = value!;
                    });
                  },
                  focusColor: Colors.white,
                  // iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.white,
                  hint: Text(
                    originLanguage,
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(Icons.keyboard_arrow_down),
                ),
                SizedBox(
                  width: 40,
                ),
                Icon(
                  Icons.arrow_right_alt_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(
                  width: 40,
                ),
                DropdownButton(
                  items: languages.map((language) {
                    return DropdownMenuItem(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      destinationLanguage = value!;
                    });
                  },
                  focusColor: Colors.white,
                  // iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.white,
                  hint: Text(
                    destinationLanguage,
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Please enter your text',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1)),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15)),
                controller: languageController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your text to translate';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  translate(
                      getLanguageCode(originLanguage),
                      getLanguageCode(destinationLanguage),
                      languageController.text.toString());
                },
                child: Text(
                  'Translate',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 41, 0, 207)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              output,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
    );
  }
}
