import 'package:alltalk_translate/providers.dart';
import 'package:alltalk_translate/widgets/translate_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translator/translator.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final translator = GoogleTranslator();
  FlutterTts flutterTts = FlutterTts();
  final TextEditingController _textController = TextEditingController();

  double volume = 1.0;
  double pitch = 1.0;
  double speechRate = 0.5;
  TranslateCard translateCard1 = TranslateCard();
  TranslateCard translateCard2 = TranslateCard();
  TranslateCard translateCard3 = TranslateCard();

  @override
  Widget build(BuildContext context) {
    // getLangs();
    List<TranslateCard> translateCardList = [
      translateCard1,
      translateCard2,
      translateCard3,
    ];

    double screenHeight = MediaQuery.of(context).size.height;
    int textFieldLineCount = screenHeight ~/ 40;
    return Scaffold(
      appBar: AppBar(title: const Text("AllTalk Translate")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${ref.watch(mainLangCodeProvider)} text"),
            GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              shrinkWrap: true,
              children: [
                translateCard1,
                //Text(translateCard1.selectedCountryAbbreviation),
                translateCard2,
                // Text(translateCard2.selectedCountryAbbreviation),
                translateCard3,
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                )
              ],
            ),
            TextField(
              controller: _textController,
              onChanged: (value) {},
              onSubmitted: (value) {},
            ),
            ElevatedButton(
              onPressed: () {
                translateCardList.forEach((translateCard) {
                  translateCard.myText = _textController.text;
                });
                ref.read(mainTextProvider.notifier).state =
                    _textController.text;
              },
              child: Text("Çevir"),
            ),
          ],
        ),
      ),
    );
  }

  getLangs() async {
    var langs = await flutterTts.getLanguages;
    print(langs);
  }
}
