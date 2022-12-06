import 'package:alltalk_translate/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class CountryFullName {
  static String getCountryFullName(String countryAbbreviation) {
    // farkli ise en-US gibi, 2. yi yaz
    // translations/ icindeki jsonlara ekleyip buraya yaz sonra
    if (countryAbbreviation == "tr") {
      return LocaleKeys.turkish.tr();
    } else if (countryAbbreviation == "us" || countryAbbreviation == "en") {
      return LocaleKeys.english_us.tr();
    } else if (countryAbbreviation == "kr" || countryAbbreviation == "ko") {
      return LocaleKeys.korean.tr();
    } else if (countryAbbreviation == "pk" || countryAbbreviation == "ur") {
      return LocaleKeys.urdu.tr();
    } else if (countryAbbreviation == "in" || countryAbbreviation == "hi") {
      return LocaleKeys.indian.tr();
    } else if (countryAbbreviation == "jp" || countryAbbreviation == "ja") {
      return LocaleKeys.japanase.tr();
    } else if (countryAbbreviation == "no" || countryAbbreviation == "nb") {
      return LocaleKeys.norwegian.tr();
    } else if (countryAbbreviation == "da" || countryAbbreviation == "dk") {
      return LocaleKeys.danish.tr();
    } else if (countryAbbreviation == "et" || countryAbbreviation == "ee") {
      return LocaleKeys.estonian.tr();
    } else if (countryAbbreviation == "vi" || countryAbbreviation == "vn") {
      return LocaleKeys.vietnamase.tr();
    } else if (countryAbbreviation == "sv" || countryAbbreviation == "se") {
      return LocaleKeys.swedish.tr();
    } else if (countryAbbreviation == "el" || countryAbbreviation == "gr") {
      return LocaleKeys.greek.tr();
    } else if (countryAbbreviation == "bn" || countryAbbreviation == "bd") {
      return LocaleKeys.bengali.tr();
    } else if (countryAbbreviation == "cs" || countryAbbreviation == "cz") {
      return LocaleKeys.czech.tr();
    } else if (countryAbbreviation == "uk" || countryAbbreviation == "ua") {
      return LocaleKeys.ukrainian.tr();
    } else if (countryAbbreviation == "ru") {
      return LocaleKeys.russian.tr();
    } else if (countryAbbreviation == "hu") {
      return LocaleKeys.hungarian.tr();
    } else if (countryAbbreviation == "fr") {
      return LocaleKeys.french.tr();
    } else if (countryAbbreviation == "de") {
      return LocaleKeys.deutsch.tr();
    } else if (countryAbbreviation == "es") {
      return LocaleKeys.spanish.tr();
    } else if (countryAbbreviation == "ro") {
      return LocaleKeys.romanian.tr();
    } else if (countryAbbreviation == "th") {
      return LocaleKeys.thai.tr();
    } else if (countryAbbreviation == "pt") {
      return LocaleKeys.portuguese.tr();
    } else if (countryAbbreviation == "fi") {
      return LocaleKeys.finnish.tr();
    } else if (countryAbbreviation == "lv") {
      return LocaleKeys.latvian.tr();
    } else if (countryAbbreviation == "pl") {
      return LocaleKeys.polish.tr();
    } else if (countryAbbreviation == "sk") {
      return LocaleKeys.slovak.tr();
    } else if (countryAbbreviation == "it") {
      return LocaleKeys.italiano.tr();
    } else if (countryAbbreviation == "bg") {
      return LocaleKeys.bulgarian.tr();
    } else if (countryAbbreviation == "id") {
      return LocaleKeys.indonesian.tr();
    } else if (countryAbbreviation == "az") {
      return LocaleKeys.azerbaijani.tr(); // might not talk
    } else {
      return "Nope";
    }
  }
}
