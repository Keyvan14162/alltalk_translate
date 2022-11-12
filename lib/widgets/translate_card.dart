import 'package:alltalk_translate/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:translator/translator.dart';
import 'package:alltalk_translate/country_constants.dart' as country_constants;

class TranslateCard extends StatefulHookConsumerWidget {
  const TranslateCard({super.key});

  @override
  ConsumerState<TranslateCard> createState() => _TranslateCardState();
}

class _TranslateCardState extends ConsumerState<TranslateCard> {
  late TextEditingController _textController;
  final translator = GoogleTranslator();
  FlutterTts flutterTts = FlutterTts();
  String selectedCountryAbbreviation = "tr";
  String selectedCountry = "tr-TR";

  final double flagImageHeight = 36;
  List<String> myLanguages = country_constants.countryCodes;

  double volume = 1.0;
  double pitch = 1.0;
  double speechRate = 0.5;
  List<String>? languages;

  String _text = "";

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    init();
    initSetting();
  }

  void init() async {
    languages = List<String>.from(await flutterTts.getLanguages);
    setState(() {});
  }

  initSetting() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(speechRate);
    // await flutterTts
    //     .setLanguage(ref.read(firstLangCodeProvider.notifier).state);
    await flutterTts.setLanguage(selectedCountry);
  }

  Future _speak() async {
    await initSetting();
    // var x = await flutterTts.speak(_firstTextController.text);
    // print(x); konusursa 1 konusmazsa 0
    //await flutterTts
    //   .setLanguage(ref.read(firstLangCodeProvider.notifier).state);
    // await flutterTts.setLanguage(selectedCountryAbbreviation);
    await flutterTts.speak(_textController.text);
  }

  Future _stop() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    int textFieldLineCount = screenHeight ~/ 40;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Stack(
                children: [
                  TextField(
                    maxLines: textFieldLineCount,
                    minLines: textFieldLineCount,
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: "Write message...",
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      _text = value.toString();
                    },
                    onSubmitted: (value) async {
                      // _textController.clear();
                      _speak();
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.volume_up,
                      ),
                      onPressed: () async {
                        _speak();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Row(
          children: [
            // ChangeLanguageButton(buttonNumber: 1),
            Container(
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
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Çevir"),
            )
          ],
        ),
      ],
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
            setState(() {
              selectedCountry = myLanguages[index];
              selectedCountryAbbreviation = countryAbbreviation;
            });
            /*
            selectedCountryAbbreviation = countryAbbreviation;
            if (widget.buttonNumber == 1) {
              ref.read(firstLangCodeProvider.notifier).state =
                  element.toString();
            } else {
              ref.read(secondLangCodeProvider.notifier).state =
                  element.toString();
            }
            */
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
