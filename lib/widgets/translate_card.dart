import 'package:alltalk_translate/providers.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translator/translator.dart';
import 'package:alltalk_translate/country_constants.dart' as country_constants;

class TranslateCard extends StatefulHookConsumerWidget {
  TranslateCard(
      {required this.cardKey,
      required this.selectedCountryAbbreviation,
      super.key});
  String selectedCountryAbbreviation;
  String myText = "";
  final UniqueKey cardKey;

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
    await flutterTts.setLanguage(selectedCountry);
  }

  Future _speak(String text) async {
    await initSetting();
    var x = await flutterTts.speak(text);
    // print(x); konusursa 1 konusmazsa 0
    // await flutterTts.setLanguage(selectedCountry);
  }

  Future _stop() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    // ozel durumlaricin else if ekle
    if (widget.selectedCountryAbbreviation == "us") {
      selectedCountry = "en-US";
    } else {
      selectedCountry =
          "${widget.selectedCountryAbbreviation}-${widget.selectedCountryAbbreviation.toUpperCase()}";
    }
    return FutureBuilder(
      future: ref.watch(mainTextProvider).translate(
            to: widget.selectedCountryAbbreviation == "us"
                ? "en"
                : widget.selectedCountryAbbreviation,
          ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: 230,
            child: Stack(
              children: [
                // back container
                Positioned(
                  top: 35,
                  left: 20,
                  child: Material(
                    child: Container(
                      height: 180.0,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: const Offset(-10.0, 10.0),
                            blurRadius: 20.0,
                            spreadRadius: 4.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // lang change
                Positioned(
                  top: 0,
                  left: 30,
                  child: Card(
                    elevation: 10.0,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      height: 150,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: PopupMenuButton(
                        itemBuilder: (context) => createPopupMenuItems(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'icons/flags/png/${widget.selectedCountryAbbreviation}.png',
                            package: 'country_icons',
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox();
                            },
                            height: 300,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // header and text
                Positioned(
                  top: 45,
                  left: 240,
                  child: Container(
                    height: 160,
                    width: 150,
                    child: Column(
                      children: [
                        Text(
                          "Language",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF363f93),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            child: Text(
                              snapshot.data.toString(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // icons
                Positioned(
                    bottom: 15,
                    left: 30,
                    child: Container(
                      width: 210,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // speak
                          Flexible(
                            child: AnimatedIconButton(
                              icons: [
                                AnimatedIconItem(
                                  icon: const Icon(
                                    Icons.volume_up,
                                    color: Colors.black,
                                  ),
                                  onPressed: () async {
                                    _speak(snapshot.data.toString());
                                  },
                                ),
                                AnimatedIconItem(
                                  icon: const Icon(
                                    Icons.volume_up,
                                    color: Colors.black,
                                  ),
                                  onPressed: () async {
                                    _speak(snapshot.data.toString());
                                  },
                                ),
                              ],
                            ),
                          ),
                          // stop
                          Flexible(
                            child: AnimatedIconButton(
                              icons: [
                                AnimatedIconItem(
                                  icon: const Icon(
                                    Icons.stop,
                                    color: Colors.black,
                                  ),
                                  onPressed: () async {
                                    _stop();
                                  },
                                ),
                                AnimatedIconItem(
                                  icon: const Icon(
                                    Icons.stop,
                                    color: Colors.black,
                                  ),
                                  onPressed: () async {
                                    _stop();
                                  },
                                ),
                              ],
                            ),
                          ),
                          // copy text
                          Flexible(
                            child: AnimatedIconButton(
                              icons: [
                                AnimatedIconItem(
                                  icon: const Icon(
                                    Icons.copy,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    print(snapshot.data.toString());
                                  },
                                ),
                                AnimatedIconItem(
                                  icon: const Icon(
                                    Icons.copy,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    print(snapshot.data.toString());
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          );
        } else {
          return Container(
            height: 230,
            child: Stack(
              children: [
                // back container
                Positioned(
                  top: 35,
                  left: 20,
                  child: Material(
                    child: Container(
                      height: 180.0,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: const Offset(-10.0, 10.0),
                            blurRadius: 20.0,
                            spreadRadius: 4.0,
                          ),
                        ],
                      ),
                      child: Shimmer.fromColors(
                        baseColor:
                            Theme.of(context).primaryColor.withOpacity(0.9),
                        highlightColor:
                            Theme.of(context).primaryColor.withOpacity(0.2),
                        child: Container(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ),
                ),
                // lang change
                Positioned(
                  top: 0,
                  left: 30,
                  child: Card(
                    elevation: 10.0,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      height: 150,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: PopupMenuButton(
                        itemBuilder: (context) => createPopupMenuItems(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Shimmer.fromColors(
                            baseColor:
                                Theme.of(context).primaryColor.withOpacity(0.9),
                            highlightColor:
                                Theme.of(context).primaryColor.withOpacity(0.2),
                            child: Container(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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

      popupMenuItemList.add(
        PopupMenuItem(
          onTap: () async {
            if (!isLanguageSelectedBefore(widget.selectedCountryAbbreviation)) {
              setState(() {
                selectedCountry = myLanguages[index];
                widget.selectedCountryAbbreviation = countryAbbreviation;
              });
            } else {
              print("Language already added");
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

  bool isLanguageSelectedBefore(String selectedCountryAbbreviation) {
    for (var card in ref.read(translateCardListProvider.notifier).state) {
      if (card.selectedCountryAbbreviation == selectedCountryAbbreviation) {
        return true;
      }
    }
    return false;
  }
}
