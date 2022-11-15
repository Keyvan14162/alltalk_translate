import 'package:alltalk_translate/widgets/translate_card.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mainTextProvider = StateProvider<String>((ref) {
  return "merhaba";
});

// eger en-US tarzi ise buraya 2. yi yaz
// burdan sonra country constants a da ekle
// sonra da helpers-getCountryFullName ekle ulke ismini
final translateCardListProvider = StateProvider<List<TranslateCard>>((ref) {
  List<TranslateCard> translateCardList = [
    TranslateCard(
      cardKey: UniqueKey(),
      selectedCountryAbbreviation: "jp",
    ),
    TranslateCard(
      cardKey: UniqueKey(),
      selectedCountryAbbreviation: "ro",
    ),
    TranslateCard(
      cardKey: UniqueKey(),
      selectedCountryAbbreviation: "es",
    ),
    TranslateCard(
      cardKey: UniqueKey(),
      selectedCountryAbbreviation: "de",
    ),
    TranslateCard(
      cardKey: UniqueKey(),
      selectedCountryAbbreviation: "fr",
    ),
    TranslateCard(
      cardKey: UniqueKey(),
      selectedCountryAbbreviation: "hu",
    ),
    TranslateCard(
      cardKey: UniqueKey(),
      selectedCountryAbbreviation: "tr",
    ),
    TranslateCard(
      cardKey: UniqueKey(),
      selectedCountryAbbreviation: "us",
    ),
    TranslateCard(
      cardKey: UniqueKey(),
      selectedCountryAbbreviation: "ru",
    ),
    TranslateCard(
      cardKey: UniqueKey(),
      selectedCountryAbbreviation: "kr",
    ),
    TranslateCard(
      cardKey: UniqueKey(),
      selectedCountryAbbreviation: "pk",
    ),
    TranslateCard(
      cardKey: UniqueKey(),
      selectedCountryAbbreviation: "in",
    ),
  ];
  return translateCardList;
});
