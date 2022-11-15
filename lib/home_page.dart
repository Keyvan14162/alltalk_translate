import 'package:alltalk_translate/providers.dart';
import 'package:alltalk_translate/widgets/translate_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alltalk_translate/country_constants.dart' as country_constants;

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  String selectedCountryAbbreviation = "tr";
  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: myAppbar(height, width, context),
      /*
      body: SingleChildScrollView(
        // reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // input area
            Container(
              height: height / 4,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor,
                    //offset: Offset(-10.0, 10.0),
                    blurRadius: 20,
                    spreadRadius: 4.0,
                  ),
                ],
                color: Theme.of(context).primaryColor,
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 20,
                    left: 0,
                    child: Container(
                      height: height / 6,
                      width: width * 0.9,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: TextField(
                        // minLines: 1,
                        // maxLines: 10,
                        style: const TextStyle(fontSize: 17),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(fontSize: 17),
                          hintText: 'Enter text to translate',
                          suffixIcon: Icon(Icons.translate),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                        ),
                        controller: _textController,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            ref.read(mainTextProvider.notifier).state =
                                _textController.text;
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount:
                  ref.read(translateCardListProvider.notifier).state.length + 1,
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
            const SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
      */
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 90,

              // collapsedHeight: 80,
              //pinned: true,
              //floating: true,
              //forceElevated: innerBoxIsScrolled,
              /*
              title: Container(
                width: width,
                child: Text("data"),
                color: Colors.white,
              ),*/

              actions: [
                SingleChildScrollView(child: addLangWidget(context)),
              ],
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // input area
                /*
                Container(
                  height: height / 4,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor,
                        //offset: Offset(-10.0, 10.0),
                        blurRadius: 20,
                        spreadRadius: 4.0,
                      ),
                    ],
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 20,
                        left: 0,
                        child: Container(
                          height: height / 6,
                          width: width * 0.9,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: TextField(
                            // minLines: 1,
                            // maxLines: 10,
                            style: const TextStyle(fontSize: 17),
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(fontSize: 17),
                              hintText: 'Enter text to translate',
                              suffixIcon: Icon(Icons.translate),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(20),
                            ),
                            controller: _textController,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                ref.read(mainTextProvider.notifier).state =
                                    _textController.text;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
 */
                SizedBox(
                  height: height * 0.05,
                ),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount:
                      ref.read(translateCardListProvider.notifier).state.length,
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
                const SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar myAppbar(double height, double width, BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      toolbarHeight: 80, // 100

      actions: [
        Column(
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
                    blurRadius: 4,
                    spreadRadius: 1.0,
                  ),
                ],
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Positioned(
                    // bottom: 0,
                    //left: 0,
                    child: Container(
                      height: height / 14,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: TextField(
                        maxLines: 1,
                        style: const TextStyle(fontSize: 17),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(fontSize: 17),
                          hintText: 'Enter text to translate',
                          suffixIcon: Icon(Icons.translate),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                        ),
                        controller: _textController,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            ref.read(mainTextProvider.notifier).state =
                                _textController.text;
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
      // leading
    );
  }

  List<Widget> createGridViewItems() {
    List<Widget> list = List.generate(
      ref.read(translateCardListProvider.notifier).state.length,
      (index) {
        return Dismissible(
          key:
              ref.read(translateCardListProvider.notifier).state[index].cardKey,
          onDismissed: (direction) {
            setState(
              () {
                ref.watch(translateCardListProvider).removeWhere(
                      (element) =>
                          element.cardKey ==
                          ref
                              .read(translateCardListProvider.notifier)
                              .state[index]
                              .cardKey,
                    );
              },
            );
          },
          child: ref.read(translateCardListProvider.notifier).state[index],
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

  Column addLangWidget(BuildContext context) {
    return Column(
      /*
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: const Divider(
            color: Colors.black,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Add New Language to Translate",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Material(
          child: Container(
            height: 80.0,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(0.0),
              boxShadow: [],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  elevation: 10.0,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    height: 60,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // color: Colors.blue,
                    ),
                    child: PopupMenuButton(
                      itemBuilder: (context) => createPopupMenuItems(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
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
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        isLanguageSelectedBefore(selectedCountryAbbreviation)
                            ? const Text(
                                "Language is already added.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                ),
                              )
                            : const Text(
                                "Language is ready to add.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                isLanguageSelectedBefore(selectedCountryAbbreviation)
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            setState(
                              () {
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
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 36,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    */
      children: [
        Center(
          child: Material(
            child: Container(
              height: 80.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 4.0,
                  ),
                ],
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    elevation: 10.0,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      height: 60,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        // color: Colors.blue,
                      ),
                      child: PopupMenuButton(
                        itemBuilder: (context) => createPopupMenuItems(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
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
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "Choose the language that will be added.",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              "Add a new language.",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  isLanguageSelectedBefore(selectedCountryAbbreviation)
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {},
                            isSelected: false,
                            icon: const Icon(
                              Icons.add,
                              size: 36,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              setState(
                                () {
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
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 36,
                              color: Colors.black,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
