import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:alltalk_translate/constants/all_talk_icons_icons.dart';
import 'package:alltalk_translate/constants/color_consts.dart';
import 'package:alltalk_translate/generated/locale_keys.g.dart';
import 'package:alltalk_translate/helpers/country_full_name.dart';
import 'package:alltalk_translate/providers.dart';
import 'package:alltalk_translate/widgets/my_drawer.dart';
import 'package:alltalk_translate/widgets/translate_card.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alltalk_translate/helpers/country_constants.dart'
    as country_constants;
import 'package:internet_connection_checker/internet_connection_checker.dart';

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

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late TextEditingController _textController;
  String selectedCountryAbbreviation = "tr";

  double myBlurRadius = 4.0;
  double mySPreadRadius = 1;
  late Color primaryColor;
  late Color backgroundColor;

  late StreamSubscription<InternetConnectionStatus> internetConnectionListener;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController();

    internetConnectionListener =
        InternetConnectionChecker().onStatusChange.listen((status) {
      ScaffoldMessenger.of(context).clearSnackBars();
      setState(() {});
    });
  }

  @override
  void dispose() {
    internetConnectionListener.cancel();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double addLangHeight = height / 14;
    primaryColor = Theme.of(context).primaryColor;
    backgroundColor = Theme.of(context).backgroundColor;

    List<Widget> translateCardListItems = createTranslateCardListItems();

    connectionStatusSnackbar();

    return Scaffold(
      appBar: myAppbar(height, width, context),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Listener(
          // when touching somewhere remove focus from textfield
          onPointerDown: (_) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.focusedChild?.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                // add lang part
                addLangWidget(
                  context,
                  addLangHeight,
                ),

                const SizedBox(
                  height: 8,
                ),
                // language list
                Container(
                  color: primaryColor.withOpacity(0.2),
                  child: ListView.builder(
                    primary: false,
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: ref
                        .read(translateCardListProvider.notifier)
                        .state
                        .length,
                    itemBuilder: (context, index) {
                      return translateCardListItems[index];
                    },
                  ),
                ),

                Text(
                  LocaleKeys.slide_language_to_remove_language.tr(),
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),

                SizedBox(
                  height: height / 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  connectionStatusSnackbar() async {
    await (InternetConnectionChecker().hasConnection).then((value) {
      if (!value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 100),
            backgroundColor: Colors.white,
            content: Text(
              LocaleKeys.no_internet_connection.tr(),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            action: SnackBarAction(
              label: LocaleKeys.refresh.tr(),
              onPressed: () {
                setState(() {});
              },
            ),
          ),
        );
      }
    });
  }

  AppBar myAppbar(double height, double width, BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white10,
      ),

      elevation: 0,
      iconTheme: IconThemeData(color: backgroundColor),

      backgroundColor: primaryColor,
      toolbarHeight: height / 9, // 100
      foregroundColor: Colors.black,
      title: Container(
        height: height / 10,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryColor,
        ),
        // menu button and textfield
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: TextField(
                  // for paste
                  enableInteractiveSelection: true,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 17,
                    color: backgroundColor,
                  ),
                  cursorColor: backgroundColor,

                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 17,
                      color: backgroundColor.withOpacity(0.6),
                    ),
                    hintText: LocaleKeys.enter_text_to_translate.tr(),
                    suffixIcon: AnimatedIconButton(
                      icons: const [
                        AnimatedIconItem(
                          icon: Icon(
                            AllTalkIcons.ok,
                            color: ColorConsts.myBlue,
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
                  onChanged: (value) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> createTranslateCardListItems() {
    List<Widget> list = List.generate(
      ref.read(translateCardListProvider.notifier).state.length,
      (index) {
        return Slidable(
          dragStartBehavior: DragStartBehavior.start,
          key:
              ref.read(translateCardListProvider.notifier).state[index].cardKey,
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {
              setState(() {
                ref.watch(translateCardListProvider).removeWhere(
                      (element) =>
                          element.cardKey ==
                          ref
                              .read(translateCardListProvider.notifier)
                              .state[index]
                              .cardKey,
                    );
              });
            }),
            children: [
              SlidableAction(
                onPressed: (context) {},
                backgroundColor: ColorConsts.myRed,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {
              setState(() {
                ref.watch(translateCardListProvider).removeWhere(
                      (element) =>
                          element.cardKey ==
                          ref
                              .read(translateCardListProvider.notifier)
                              .state[index]
                              .cardKey,
                    );
              });
            }),
            children: [
              SlidableAction(
                onPressed: (context) {},
                backgroundColor: ColorConsts.myRed,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Card(
            elevation: 4,
            child: ref.read(translateCardListProvider.notifier).state[index],
          ),
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
              Text(
                CountryFullName.getCountryFullName(
                  element.split("-")[0].toString(),
                ),
              ),
            ],
          ),
        ),
      );
    });
    return popupMenuItemList;
  }

  Widget addLangWidget(BuildContext context, double addLangHeight) {
    return Material(
      child: Container(
        height: addLangHeight + 10,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(0.1),
              blurRadius: myBlurRadius,
              spreadRadius: mySPreadRadius,
            ),
          ],
          color: primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // choose lang
            Flexible(
              child: Card(
                margin: const EdgeInsets.all(0),
                elevation: 0,
                shadowColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Container(
                  height: 45,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.grey,
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: primaryColor,
                foregroundColor: backgroundColor,
              ),
              onPressed: () {
                addSelectedLanguage();
              },
              child: Row(
                children: [
                  Text(
                    LocaleKeys.add_selected_language.tr(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  // icon
                  AnimatedIconButton(
                    icons: const [
                      AnimatedIconItem(
                        icon: Icon(
                          AllTalkIcons.plus,
                          size: 24,
                          color: ColorConsts.myRed,
                        ),
                      ),
                    ],
                    onPressed: () {
                      addSelectedLanguage();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  addSelectedLanguage() {
    isLanguageSelectedBefore(selectedCountryAbbreviation)
        ?
        // laguage already added
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.white,
              content: Text(
                "${CountryFullName.getCountryFullName(selectedCountryAbbreviation)} ${LocaleKeys.already_on_list.tr()}",
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              action: SnackBarAction(
                label: LocaleKeys.ok.tr(),
                onPressed: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                },
              ),
            ),
          )
        :
        // add to provider list
        setState(
            () {
              if (!isLanguageSelectedBefore(selectedCountryAbbreviation)) {
                ref.watch(translateCardListProvider).add(TranslateCard(
                      cardKey: UniqueKey(),
                      selectedCountryAbbreviation: selectedCountryAbbreviation,
                    ));
              }
            },
          );
    // show confirm snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.white,
        content: Text(
          "${CountryFullName.getCountryFullName(selectedCountryAbbreviation)} ${LocaleKeys.added_to_list.tr()}",
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        action: SnackBarAction(
          label: LocaleKeys.ok.tr(),
          onPressed: () {},
        ),
      ),
    );
  }
}
