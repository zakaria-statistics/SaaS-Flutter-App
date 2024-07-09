import 'dart:ui';

class Language {

  final int id;
  final String flag; //icon download package pour les drapeu, type
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList(){
    return <Language>[
      Language(1, 'assets/svg/us.svg', "English", "en"),
      Language(2, 'assets/svg/fr.svg', "French", "fr"),
    ];
  }

}