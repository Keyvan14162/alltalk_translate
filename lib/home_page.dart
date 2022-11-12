import 'package:alltalk_translate/providers.dart';
import 'package:alltalk_translate/widgets/translate_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:translator/translator.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getLangs();
    return Scaffold(
      appBar: AppBar(title: const Text("AllTalk Translate")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("${ref.watch(firstLangCodeProvider)} text"),
            Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Row(
                    children: const [
                      TranslateCard(),
                      TranslateCard(),
                      TranslateCard(),
                      TranslateCard(),
                    ],
                  );
                },
              ),
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
