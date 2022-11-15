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
    } else {
      return "Nope";
    }
  }
}
