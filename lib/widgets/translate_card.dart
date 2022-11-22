import 'package:alltalk_translate/all_talk_icons_icons.dart';
import 'package:alltalk_translate/helpers.dart';
import 'package:alltalk_translate/providers.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool myIsExpanded = false;

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
    await flutterTts.setVolume(ref.read(volumeProvider.notifier).state);
    await flutterTts.setPitch(ref.read(pitchProvider.notifier).state);
    await flutterTts.setSpeechRate(ref.read(speechRateProvider.notifier).state);
    await flutterTts.setLanguage(selectedCountry);
    print("Volume : ${ref.read(volumeProvider.notifier).state}");
    print("Pitch : ${ref.read(pitchProvider.notifier).state}");
    print("SpeechRate : ${ref.read(speechRateProvider.notifier).state}");
  }

  Future _speak(String text) async {
    await initSetting();
    await flutterTts.speak(text);
    // print(x); konusursa 1 konusmazsa 0
  }

  Future _stop() async {
    await flutterTts.stop();
  }

  double myBlurRadius = 4.0;
  double mySPreadRadius = 1.0;

  double headerSize = 20;
  double fontsize = 18;

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
    return FutureBuilder(
      future: ref.watch(mainTextProvider).translate(
            to: selectedCountry.split("-")[0].toLowerCase(),
          ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ExpansionPanelList(
            elevation: 0,
            dividerColor: Colors.white,
            expandedHeaderPadding: const EdgeInsets.all(8.0),
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                myIsExpanded = !isExpanded;
              });
            },
            children: [
              getExpansionPanelListItems(
                snapshot.data.toString(),
                width,
                height,
              ),
            ],
          );
        } else {
          // shimmer
          return expansionPanelItemShimmer(height);
        }
      },
    );
  }

  Container expansionPanelItemShimmer(double height) {
    return Container(
      color: Colors.white,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.4),
        highlightColor: Colors.grey.withOpacity(0.9),
        direction: ShimmerDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                height: height / 11,
                width: (height / 11) * 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: PopupMenuButton(
                  itemBuilder: (context) => createPopupMenuItems(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: const SizedBox(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                Helpers.getCountryFullName(
                  widget.selectedCountryAbbreviation,
                ),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                    ),
                  ),
                  Flexible(
                    child: AnimatedIconButton(
                      icons: const [
                        AnimatedIconItem(
                          icon: Icon(
                            Icons.stop,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // copy text
                  Flexible(
                    child: AnimatedIconButton(
                      icons: const [
                        AnimatedIconItem(
                          icon: Icon(
                            Icons.copy,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height / 7,
            ),
          ],
        ),
      ),
    );
  }

  getExpansionPanelListItems(String text, double width, double height) {
    return ExpansionPanel(
      canTapOnHeader: true,
      isExpanded: myIsExpanded,
      //backgroundColor: flagDominantColor,
      headerBuilder: (context, isExpanded) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // lang change
          Card(
            elevation: 0,
            shadowColor: Colors.grey.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Container(
              height: height / 18,
              width: (height / 18) * 1.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                /*
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    // offset: const Offset(0, 10.0),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],*/
              ),
              child: PopupMenuButton(
                itemBuilder: (context) => createPopupMenuItems(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
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
          // header
          Expanded(
            child: Shimmer.fromColors(
              direction: ShimmerDirection.ltr,
              baseColor: Colors.red,
              highlightColor: Colors.yellow,
              period: const Duration(milliseconds: 3000),
              child: Text(
                Helpers.getCountryFullName(
                  widget.selectedCountryAbbreviation,
                ),
                style: TextStyle(
                  fontSize: headerSize,
                  color: Colors.red.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // icons
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // speak
                Flexible(
                  child: Shimmer.fromColors(
                    direction: ShimmerDirection.ltr,
                    baseColor: Colors.black,
                    highlightColor: Colors.white,
                    period: const Duration(milliseconds: 3000),
                    loop: 1,
                    child: AnimatedIconButton(
                      icons: [
                        AnimatedIconItem(
                          icon: Icon(
                            AllTalkIcons.volume_high,
                            size: headerSize,
                          ),
                        ),
                      ],
                      onPressed: () async {
                        _speak(text); // snapshot.data.tostring
                      },
                    ),
                  ),
                ),
                // stop
                Flexible(
                  child: Shimmer.fromColors(
                    direction: ShimmerDirection.ltr,
                    baseColor: Colors.black,
                    highlightColor: Colors.white,
                    period: const Duration(milliseconds: 3000),
                    loop: 1,
                    child: AnimatedIconButton(
                      icons: [
                        AnimatedIconItem(
                          icon: Icon(
                            AllTalkIcons.pause_outline,
                            size: headerSize,
                          ),
                        ),
                      ],
                      onPressed: () async {
                        _stop();
                      },
                    ),
                  ),
                ),
                // copy text
                Flexible(
                  child: Shimmer.fromColors(
                    direction: ShimmerDirection.ltr,
                    baseColor: Colors.black,
                    highlightColor: Colors.white,
                    period: const Duration(milliseconds: 3000),
                    loop: 1,
                    child: AnimatedIconButton(
                      icons: [
                        AnimatedIconItem(
                          icon: Icon(
                            AllTalkIcons.bookmark,
                            size: headerSize,
                          ),
                        ),
                      ],
                      onPressed: () async {
                        print(text);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height / 12,
          ),
        ],
      ),
      // text part
      body: Container(
        height: width * 0.6, // 180
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(1),
              BlendMode.dstATop,
            ),
            image: AssetImage(
              "icons/flags/png/${widget.selectedCountryAbbreviation}.png",
              package: 'country_icons',
            ),
          ),
        ),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w400,
                    fontSize: fontsize,
                  ),
                ),
              ),
            ),
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
