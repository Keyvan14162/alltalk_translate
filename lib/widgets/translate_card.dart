import 'package:alltalk_translate/helpers.dart';
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
    await flutterTts.speak(text);
    // print(x); konusursa 1 konusmazsa 0
  }

  Future _stop() async {
    await flutterTts.stop();
  }

  double myBlurRadius = 10.0;
  double mySPreadRadius = 1.0;

  @override
  Widget build(BuildContext context) {
    // ozel durumlaricin else if ekle
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (widget.selectedCountryAbbreviation == "us") {
      selectedCountry = "en-US";
    } else if (widget.selectedCountryAbbreviation == "kr") {
      selectedCountry = "ko-KR";
    } else if (widget.selectedCountryAbbreviation == "pk") {
      selectedCountry = "ur-PK";
    } else if (widget.selectedCountryAbbreviation == "in") {
      selectedCountry = "hi-IN";
    } else if (widget.selectedCountryAbbreviation == "jp") {
      selectedCountry = "ja-JP";
    } else {
      selectedCountry =
          "${widget.selectedCountryAbbreviation}-${widget.selectedCountryAbbreviation.toUpperCase()}";
    }
    print(selectedCountry);
    return FutureBuilder(
      future: ref.watch(mainTextProvider).translate(
            //to: widget.selectedCountryAbbreviation == "us"
            //  ? "en"
            //: widget.selectedCountryAbbreviation,
            to: selectedCountry.split("-")[0].toLowerCase(),
          ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: height / 3.2, // 230
            child: Stack(
              children: [
                // background
                Positioned(
                  top: height / 21, // 35
                  left: width / 20, // 20
                  child: Material(
                    // back flag image
                    child: Container(
                      height: height / 4.1, // 180
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            offset: const Offset(0, 10.0),
                            blurRadius: myBlurRadius,
                            spreadRadius: mySPreadRadius,
                          ),
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.2),
                            BlendMode.dstATop,
                          ),
                          image: AssetImage(
                            "icons/flags/png/${widget.selectedCountryAbbreviation}.png",
                            package: 'country_icons',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // lang change
                Positioned(
                  top: 10,
                  left: 0,
                  child: Card(
                    elevation: 10.0,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      height: 120, //height / 6.1
                      width: 160, //(height / 6.1) * (4 / 3)
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: const Offset(0, 10.0),
                            blurRadius: myBlurRadius,
                            spreadRadius: mySPreadRadius,
                          ),
                        ],
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
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // header and text
                Positioned(
                  top: height / 20, // 45
                  left: width / 2.3, // 180
                  child: Container(
                    height: height / 4.4, // 160
                    width: width / 2, // 200
                    child: Column(
                      children: [
                        Shimmer.fromColors(
                          direction: ShimmerDirection.ltr,
                          baseColor: Colors.red,
                          highlightColor: Colors.yellow,
                          period: const Duration(milliseconds: 3000),
                          child: Text(
                            Helpers.getCountryFullName(
                              widget.selectedCountryAbbreviation,
                            ),
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.red.withOpacity(0.7),
                              fontWeight: FontWeight.bold,
                            ),
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
                    bottom: height / 30, // 25
                    left: width / 19, // 20
                    child: Container(
                      width: width / 2.6, // 160
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // speak
                          Flexible(
                            child: AnimatedIconButton(
                              icons: const [
                                AnimatedIconItem(
                                  icon: Icon(
                                    Icons.volume_up,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                              onPressed: () async {
                                _speak(snapshot.data.toString());
                              },
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
          // shimmer
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              // offset: const Offset(-10.0, 10.0),
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
                    top: 10,
                    left: 0,
                    child: Card(
                      elevation: 10.0,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 120,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: PopupMenuButton(
                          itemBuilder: (context) => createPopupMenuItems(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              width: 200,
                              height: 150,
                              child: Shimmer.fromColors(
                                baseColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.9),
                                highlightColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.2),
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
                  ),
                ],
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

      popupMenuItemList.add(
        PopupMenuItem(
          onTap: () {
            if (!isLanguageSelectedBefore(countryAbbreviation)) {
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
                  print(error);
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
