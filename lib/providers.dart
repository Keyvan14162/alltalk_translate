import 'package:hooks_riverpod/hooks_riverpod.dart';

final firstLangCodeProvider = StateProvider<String>((ref) {
  return "tr-TR";
});
