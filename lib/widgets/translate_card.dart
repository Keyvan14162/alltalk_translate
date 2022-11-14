import 'package:alltalk_translate/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translator/translator.dart';
import 'package:alltalk_translate/country_constants.dart' as country_constants;

class TranslateCard extends StatefulHookConsumerWidget {
  TranslateCard({super.key});
  String selectedCountryAbbreviation = "tr";
  String myText = "";

  @override
  ConsumerState<TranslateCard> createState() => _TranslateCardState();
}

class _TranslateCardState extends ConsumerState<TranslateCard> {
  final translator = GoogleTranslator();
  FlutterTts flutterTts = FlutterTts();
  String selectedCountry = "tr-TR";

  final double flagImageHeight = 36;
  List<String> myLanguages = country_constants.countryCodes;

  double volume = 1.0;
  double pitch = 1.0;
  double speechRate = 0.5;
  List<String>? languages;

  @override
  void initState() {
    super.initState();
    // init();
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

  Future _speak(String text) async {
    await initSetting();
    var x = await flutterTts.speak(text);
    // print(x); konusursa 1 konusmazsa 0
    //await flutterTts
    //   .setLanguage(ref.read(firstLangCodeProvider.notifier).state);
    // await flutterTts.setLanguage(selectedCountryAbbreviation);
  }

  Future _stop() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    int textFieldLineCount = screenHeight ~/ 40;
    // translateText();
    return FutureBuilder(
      future: ref.watch(mainTextProvider).translate(
            to: widget.selectedCountryAbbreviation == "us"
                ? "en"
                : widget.selectedCountryAbbreviation,
          ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: [
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(snapshot.data.toString()),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Row(
                  children: [
                    PopupMenuButton(
                      itemBuilder: (context) => createPopupMenuItems(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'icons/flags/png/${widget.selectedCountryAbbreviation}.png',
                          package: 'country_icons',
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox();
                          },
                          height: flagImageHeight,
                          width: flagImageHeight * 1.5,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.volume_up,
                      ),
                      onPressed: () async {
                        _speak(snapshot.data.toString());
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return SizedBox(
            height: 300,
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).primaryColor.withOpacity(0.9),
              highlightColor: Theme.of(context).primaryColor.withOpacity(0.2),
              child: Container(
                height: 300,
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
            ),
          );
        }
      },
    );
  }

  List<PopupMenuItem> createPopupMenuItems() {
    List<PopupMenuItem> popupMenuItemList = [];
    // widget.languages?
    myLanguages.asMap().forEach((index, element) {
      List<String> countryNameList = element.toString().split("-");
      // print(countryNameList);
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
              widget.selectedCountryAbbreviation = countryAbbreviation;
              // ref.read(mainTextProvider.notifier).state = countryAbbreviation;
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

  translateMainText() async {
    var translatedText = await translator.translate(
      ref.watch(mainTextProvider),
      // from: selectedCountryAbbreviation == "us"
      //  ? "en"
      //   : selectedCountryAbbreviation,
      to: widget.selectedCountryAbbreviation == "us"
          ? "en"
          : widget.selectedCountryAbbreviation,
    );
    return translatedText.text;
  }
}
