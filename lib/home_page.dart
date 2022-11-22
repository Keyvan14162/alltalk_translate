import 'package:alltalk_translate/all_talk_icons_icons.dart';
import 'package:alltalk_translate/providers.dart';
import 'package:alltalk_translate/widgets/translate_card.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alltalk_translate/country_constants.dart' as country_constants;
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  String selectedCountryAbbreviation = "tr";

  // Color firstColor = Color.fromARGB(255, 1, 24, 55);
  // Color secondColor = Color.fromARGB(255, 255, 89, 100);
  Color firstColor = Colors.white;
  Color secondColor = Color.fromARGB(255, 49, 33, 33);
  Color thirdColor = Color.fromARGB(255, 255, 231, 76);
  double myBlurRadius = 4.0;
  double mySPreadRadius = 1;

  @override
  void initState() {
    super.initState();
  }

  final List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double addLangHeight = height / 14;

    return Scaffold(
      appBar: myAppbar(height, width, context),
      body: NestedScrollView(
        clipBehavior: Clip.none,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // add lang
            SliverAppBar(
              backgroundColor: Colors.white,
              toolbarHeight: addLangHeight + 20,
              actions: [
                addLangWidget(
                  context,
                  addLangHeight,
                ),
              ],
            ),
          ];
        },
        body: Container(
          color: Colors.white,
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),

                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: ref
                        .read(translateCardListProvider.notifier)
                        .state
                        .length,
                    itemBuilder: (context, index) {
                      return createGridViewItems()[index];
                    },
                  ),
                  // cevir
                  ElevatedButton(
                    onPressed: () {
                      ref.read(mainTextProvider.notifier).state =
                          _textController.text;
                    },
                    child: const Text("Çevir"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar myAppbar(double height, double width, BuildContext context) {
    return AppBar(
      elevation: 0,

      backgroundColor: firstColor,
      toolbarHeight: height / 9, // 100

      actions: [
        Flexible(
          child: Column(
            children: [
              Container(
                height: height / 10,
                width: width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      //offset: const Offset(-10.0, 10.0),
                      blurRadius: myBlurRadius,
                      spreadRadius: mySPreadRadius,
                    ),
                  ],
                  color: Colors.white,
                ),
                // menu button and textfield
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        ZoomDrawer.of(context)!.toggle();
                      },
                      icon: Icon(
                        AllTalkIcons.cog,
                        color: Colors.black,
                        size: 32,
                      ),
                    ),
                    Container(
                      width: width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: TextField(
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.grey.withOpacity(0.9),
                          ),
                          hintText: 'Enter text to translate',
                          suffixIcon: AnimatedIconButton(
                            icons: [
                              AnimatedIconItem(
                                icon: Icon(
                                  AllTalkIcons.ok,
                                  // size: 24,
                                  color: Colors.cyan,
                                ),
                              ),
                            ],
                            onPressed: () {
                              if (_textController.text.isNotEmpty) {
                                ref.read(mainTextProvider.notifier).state =
                                    _textController.text;
                              }
                            },
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(20),
                        ),
                        controller: _textController,
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            ref.read(mainTextProvider.notifier).state =
                                _textController.text;
                          }
                        },
                        onChanged: (value) {
                          /*
                        if (value.isNotEmpty) {
                          ref.read(mainTextProvider.notifier).state =
                              _textController.text;
                        }
                        */
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> createGridViewItems() {
    List<Widget> list = List.generate(
      ref.read(translateCardListProvider.notifier).state.length,
      (index) {
        return Column(
          children: [
            Dismissible(
              key: ref
                  .read(translateCardListProvider.notifier)
                  .state[index]
                  .cardKey,
              onDismissed: (direction) {
                // SSSSSSSEEEEEEETTTTT SSSSSSTTTTTAAAATTTTEEEE
                ref.watch(translateCardListProvider).removeWhere(
                      (element) =>
                          element.cardKey ==
                          ref
                              .read(translateCardListProvider.notifier)
                              .state[index]
                              .cardKey,
                    );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(1),
                      blurStyle: BlurStyle.normal,
                      offset: const Offset(0, -1),
                      blurRadius: myBlurRadius,
                      spreadRadius: mySPreadRadius,
                    ),
                  ],
                ),
                child:
                    ref.read(translateCardListProvider.notifier).state[index],
              ),
            ),
            SizedBox(
              height: 0,
            )
          ],
        );
      },
    );

    return list;
  }

  bool isLanguageSelectedBefore(String selectedCountryAbbreviation) {
    for (var card in ref.read(translateCardListProvider.notifier).state) {
      if (card.selectedCountryAbbreviation == selectedCountryAbbreviation) {
        return true;
      }
    }
    return false;
  }

  List<PopupMenuItem> createPopupMenuItems() {
    List<PopupMenuItem> popupMenuItemList = [];
    country_constants.countryCodes.asMap().forEach((index, element) {
      List<String> countryNameList = element.toString().split("-");
      String countryAbbreviation = "";
      if (countryNameList.length == 1) {
        countryAbbreviation = countryNameList[0];
      } else if (countryNameList.length == 2) {
        countryAbbreviation = countryNameList[1].toLowerCase();
      }

      popupMenuItemList.add(
        PopupMenuItem(
          onTap: () {
            setState(() {
              selectedCountryAbbreviation = countryAbbreviation;
            });
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

  addLangWidget(BuildContext context, double addLangHeight) {
    return Flexible(
      child: Column(
        children: [
          Center(
            child: Material(
              child: Container(
                height: addLangHeight,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: myBlurRadius,
                      spreadRadius: mySPreadRadius,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // choose lang
                    Flexible(
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        elevation: 0,
                        shadowColor: secondColor.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Container(
                          height: 45,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: secondColor,
                          ),
                          child: PopupMenuButton(
                            itemBuilder: (context) => createPopupMenuItems(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: Image.asset(
                                'icons/flags/png/$selectedCountryAbbreviation.png',
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

                    // text and button
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () async {
                            isLanguageSelectedBefore(
                                    selectedCountryAbbreviation)
                                ? () {}
                                : setState(() {
                                    if (!isLanguageSelectedBefore(
                                        selectedCountryAbbreviation)) {
                                      ref.watch(translateCardListProvider).add(
                                            TranslateCard(
                                              cardKey: UniqueKey(),
                                              selectedCountryAbbreviation:
                                                  selectedCountryAbbreviation,
                                            ),
                                          );
                                    }
                                  });
                          },
                          child: Row(
                            children: [
                              const Text(
                                "Add Selected Language",
                                style: TextStyle(fontSize: 16),
                              ),
                              // icon
                              AnimatedIconButton(
                                icons: [
                                  AnimatedIconItem(
                                    icon: Icon(
                                      AllTalkIcons.plus,
                                      size: 24,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                                onPressed: () {
                                  isLanguageSelectedBefore(
                                          selectedCountryAbbreviation)
                                      ? () {}
                                      : setState(
                                          () {
                                            if (!isLanguageSelectedBefore(
                                                selectedCountryAbbreviation)) {
                                              ref
                                                  .watch(
                                                      translateCardListProvider)
                                                  .add(
                                                    TranslateCard(
                                                      cardKey: UniqueKey(),
                                                      selectedCountryAbbreviation:
                                                          selectedCountryAbbreviation,
                                                    ),
                                                  );
                                            }
                                          },
                                        );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
