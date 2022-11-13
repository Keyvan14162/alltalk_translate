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
