import 'package:alltalk_translate/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangeLanguageButton extends StatefulHookConsumerWidget {
  const ChangeLanguageButton({required this.languages, super.key});
  final List<String>? languages;

  @override
  ConsumerState<ChangeLanguageButton> createState() =>
      _ChangeLanguageButtonState();
}

class _ChangeLanguageButtonState extends ConsumerState<ChangeLanguageButton> {
  String selectedCountryAbbreviation = "tr";
  final double flagImageHeight = 36;
  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 14),
      child: PopupMenuButton(
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(8),
        //   ),
        // ),
        itemBuilder: (context) => createPopupMenuItems(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'icons/flags/png/$selectedCountryAbbreviation.png',
            package: 'country_icons',
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox();
            },
            height: flagImageHeight,
            width: flagImageHeight * 1.5,
          ),
        ),
      ),
    );
  }

  List<PopupMenuItem> createPopupMenuItems() {
    List<PopupMenuItem> popupMenuItemList = [];
    widget.languages?.asMap().forEach((index, element) {
      List<String> countryNameList = element.toString().split("-");
      String countryAbbreviation = "";
      if (countryNameList.length == 1) {
        countryAbbreviation = countryNameList[0];
      } else if (countryNameList.length == 2) {
        countryAbbreviation = countryNameList[1].toLowerCase();
      }

      popupMenuItemList.add(
        PopupMenuItem(
          onTap: () async {
            selectedCountryAbbreviation = countryAbbreviation;
            ref.read(langCodeProvider.notifier).state = element.toString();
            await flutterTts
                .setLanguage(ref.read(langCodeProvider.notifier).state);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'icons/flags/png/$countryAbbreviation.png',
                package: 'country_icons',
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox();
                },
                height: 20,
                width: 30,
              ),
              Text(element),
            ],
          ),
        ),
      );
    });
    return popupMenuItemList;
  }
}
