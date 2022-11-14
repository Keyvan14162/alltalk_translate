import 'package:alltalk_translate/widgets/translate_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mainLangCodeProvider = StateProvider<String>((ref) {
  return "tr-TR";
});

final mainLangCodeAbbreviationProvider = StateProvider<String>((ref) {
  return "tr";
});
final mainTextProvider = StateProvider<String>((ref) {
  return "merhaba";
});

final translateCardListProvider = StateProvider<List<TranslateCard>>((ref) {
  List<TranslateCard> translateCardList = [
    TranslateCard(cardKey: UniqueKey()),
    TranslateCard(cardKey: UniqueKey()),
    TranslateCard(cardKey: UniqueKey()),
    TranslateCard(cardKey: UniqueKey()),
    TranslateCard(cardKey: UniqueKey()),
    TranslateCard(cardKey: UniqueKey()),
    TranslateCard(cardKey: UniqueKey()),
    TranslateCard(cardKey: UniqueKey()),
    TranslateCard(cardKey: UniqueKey()),
    TranslateCard(cardKey: UniqueKey()),
    TranslateCard(cardKey: UniqueKey()),
    TranslateCard(cardKey: UniqueKey()),
  ];
  return translateCardList;
});
