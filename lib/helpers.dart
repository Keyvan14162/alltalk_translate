class Helpers {
  static String getCountryFullName(String countryAbbreviation) {
    // farkli ise en-US gibi, 2. yi yaz
    if (countryAbbreviation == "tr") {
      return "Turkey";
    } else if (countryAbbreviation == "ru") {
      return "Russian";
    } else if (countryAbbreviation == "us") {
      return "English-US";
    } else if (countryAbbreviation == "kr") {
      return "Korean";
    } else if (countryAbbreviation == "pk") {
      return "Urdu";
    } else if (countryAbbreviation == "in") {
      return "Indiand";
    } else if (countryAbbreviation == "hu") {
      return "Hungarian";
    } else if (countryAbbreviation == "fr") {
      return "French";
    } else if (countryAbbreviation == "de") {
      return "Deutsch";
    } else if (countryAbbreviation == "es") {
      return "Spanish";
    } else if (countryAbbreviation == "ro") {
      return "Romanian";
    } else if (countryAbbreviation == "jp") {
      return "Japanase";
    } else {
      return "Nope";
    }
  }
}
