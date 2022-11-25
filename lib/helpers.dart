import 'package:alltalk_translate/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class Helpers {
  static String getCountryFullName(String countryAbbreviation) {
    // farkli ise en-US gibi, 2. yi yaz
    // translations/ icindeki jsonlara ekleyip buraya yaz sonra
    if (countryAbbreviation == "tr") {
      return LocaleKeys.turkish.tr();
    } else if (countryAbbreviation == "ru") {
      return LocaleKeys.russian.tr();
    } else if (countryAbbreviation == "us" || countryAbbreviation == "en") {
      return LocaleKeys.english_us.tr();
    } else if (countryAbbreviation == "kr" || countryAbbreviation == "ko") {
      return LocaleKeys.korean.tr();
    } else if (countryAbbreviation == "pk" || countryAbbreviation == "ur") {
      return LocaleKeys.urdu.tr();
    } else if (countryAbbreviation == "in" || countryAbbreviation == "hi") {
      return LocaleKeys.indian.tr();
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
    } else if (countryAbbreviation == "jp" || countryAbbreviation == "ja") {
      return LocaleKeys.japanase.tr();
    } else {
      return "Nope";
    }
  }
}
