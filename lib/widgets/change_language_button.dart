import 'package:alltalk_translate/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alltalk_translate/country_constants.dart' as country_constants;

class ChangeLanguageButton extends StatefulHookConsumerWidget {
  const ChangeLanguageButton({required this.buttonNumber, super.key});
  final int buttonNumber;

  @override
  ConsumerState<ChangeLanguageButton> createState() =>
      _ChangeLanguageButtonState();
}

class _ChangeLanguageButtonState extends ConsumerState<ChangeLanguageButton> {
  String selectedCountryAbbreviation = "tr";
  final double flagImageHeight = 36;
  List<String> myLanguages = country_constants.countryCodes;

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
    // widget.languages?
    myLanguages.asMap().forEach((index, element) {
      List<String> countryNameList = element.toString().split("-");
      print(countryNameList);
      String countryAbbreviation = "";
      if (countryNameList.length == 1) {
        countryAbbreviation = countryNameList[0];
      } else if (countryNameList.length == 2) {
        countryAbbreviation = countryNameList[1].toLowerCase();
      }
      // print(countryAbbreviation);

      popupMenuItemList.add(
        PopupMenuItem(
          onTap: () async {
            selectedCountryAbbreviation = countryAbbreviation;
            if (widget.buttonNumber == 1) {
              ref.read(firstLangCodeProvider.notifier).state =
                  element.toString();
            } else {
              ref.read(secondLangCodeProvider.notifier).state =
                  element.toString();
            }
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
