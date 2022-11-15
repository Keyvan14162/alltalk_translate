import 'package:alltalk_translate/widgets/translate_card.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mainTextProvider = StateProvider<String>((ref) {
  return "merhaba";
});

final translateCardListProvider = StateProvider<List<TranslateCard>>((ref) {
  List<TranslateCard> translateCardList = [
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
  ];
  return translateCardList;
});
