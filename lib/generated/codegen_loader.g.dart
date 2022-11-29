// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> en = {
    "enter_text_to_translate": "Enter text to translate",
    "add_selected_language": "Add Selected Language",
    "volume": "Volume",
    "pitch": "Pitch",
    "speech_rate": "Speech Rate",
    "reset": "Reset",
    "about": "About",
    "ok": "Ok",
    "hello": "Hello!",
    "about_first_part": "about first",
    "about_second_part": "about second",
    "already_on_list": "already on list",
    "added_to_list": "added to list",
    "language_already_added": "Language already added",
    "turkish": "Turkish",
    "russian": "Russian",
    "english_us": "English-US",
    "korean": "Korean",
    "urdu": "Urdu",
    "indian": "Indian",
    "hungarian": "Hungarian",
    "french": "French",
    "deutsch": "Deutsch",
    "spanish": "Spanish",
    "romanian": "Romanian",
    "japanase": "Japanase"
  };
  static const Map<String, dynamic> tr = {
    "enter_text_to_translate": "Çevrilecek metin",
    "add_selected_language": "Seçili Dili Ekle",
    "volume": "Ses",
    "pitch": "Akord",
    "speech_rate": "Konuşma Hızı",
    "reset": "Sıfırla",
    "about": "Hakkında",
    "ok": "Tamam",
    "hello": "Merhaba!",
    "about_first_part": "about ilk",
    "about_second_part": "about ikinci",
    "already_on_list": "zaten listede",
    "added_to_list": "listeye eklendi",
    "language_already_added": "Dil zaten eklendi",
    "turkish": "Türkçe",
    "russian": "Rusça",
    "english_us": "İngilizce-US",
    "korean": "Korece",
    "urdu": "Urduca",
    "indian": "Hintçe",
    "hungarian": "Macarca",
    "french": "Fransızca",
    "deutsch": "Almanca",
    "spanish": "İspanyolca",
    "romanian": "Romence",
    "japanase": "Japonca"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "en": en,
    "tr": tr
  };
}
