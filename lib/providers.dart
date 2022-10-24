import 'package:hooks_riverpod/hooks_riverpod.dart';

final langCodeProvider = StateProvider<String>((ref) {
  return "tr-TR";
});
