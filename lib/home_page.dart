import 'package:alltalk_translate/providers.dart';
import 'package:alltalk_translate/widgets/change_language_button.dart';
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
  late TextEditingController _firstTextController;
  final translator = GoogleTranslator();
  late TextEditingController _secondTextController;
  FlutterTts flutterTts = FlutterTts();

  double volume = 1.0;
  double pitch = 1.0;
  double speechRate = 0.5;
  List<String>? languages;

  String _text = "";

  @override
  void initState() {
    super.initState();
    _firstTextController = TextEditingController();
    _secondTextController = TextEditingController();
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
  }

  Future _speak(int buttonNumber) async {
    await initSetting();
    // var x = await flutterTts.speak(_firstTextController.text);
    // print(x); konusursa 1 konusmazsa 0
    if (buttonNumber == 1) {
      await flutterTts
          .setLanguage(ref.read(firstLangCodeProvider.notifier).state);
      await flutterTts.speak(_firstTextController.text);
    } else {
      await flutterTts
          .setLanguage(ref.read(secondLangCodeProvider.notifier).state);
      await flutterTts.speak(_secondTextController.text);
    }
  }

  Future _stop() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    // getLangs();
    double screenHeight = MediaQuery.of(context).size.height;
    int textFieldLineCount = screenHeight ~/ 40;
    return Scaffold(
      appBar: AppBar(title: const Text("AllTalk Translate")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("${ref.watch(firstLangCodeProvider)} text"),
            Text("${ref.watch(secondLangCodeProvider)} text"),

            // Text field
            Row(
              children: [
                // first
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Stack(
                          children: [
                            TextField(
                              maxLines: textFieldLineCount,
                              minLines: textFieldLineCount,
                              controller: _firstTextController,
                              decoration: const InputDecoration(
                                hintText: "Write message...",
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                _text = value.toString();
                              },
                              onSubmitted: (value) async {
                                // _textController.clear();
                                _speak(1);
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
                                  _speak(1);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // second
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Stack(
                          children: [
                            TextField(
                              maxLines: textFieldLineCount,
                              minLines: textFieldLineCount,
                              controller: _secondTextController,
                              decoration: const InputDecoration(
                                hintText: "Write message...",
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                _text = value.toString();
                              },
                              onSubmitted: (value) async {
                                // _textController.clear();
                                _speak(2);
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
                                  _speak(2);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // change icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChangeLanguageButton(buttonNumber: 1),

                // ilerde buraya basinca diller degissin
                const Icon(Icons.keyboard_double_arrow_right_outlined),
                ChangeLanguageButton(
                  buttonNumber: 2,
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () async {
                var translatedText = await translator
                    .translate(_firstTextController.text, from: "tr", to: 'en');
                print(translatedText);
              },
              child: const Text("Çevir"),
            )
            /*
            // speak-stop button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    //flutterTts.awaitSpeakCompletion(true);
                    _speak();
                  },
                  child: const Text("Konuş"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _stop();
                  },
                  child: const Text("Sus"),
                ),
              ],
            ),

            // volume slider
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text(
                      "Volume",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Slider(
                    min: 0.0,
                    max: 1.0,
                    value: volume,
                    onChanged: (value) {
                      setState(() {
                        volume = value;
                      });
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      double.parse(
                        (volume).toStringAsFixed(2),
                      ).toString(),
                      style: const TextStyle(fontSize: 17),
                    ),
                  )
                ],
              ),
            ),

            // ton(galiba) slider
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text(
                      "Pitch",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Slider(
                    min: 0.5,
                    max: 2.0,
                    value: pitch,
                    onChanged: (value) async {
                      setState(() {
                        pitch = value;
                      });
                      // await flutterTts.setPitch(pitch);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                        double.parse((pitch).toStringAsFixed(2)).toString(),
                        style: const TextStyle(fontSize: 17)),
                  )
                ],
              ),
            ),

            // speech rate
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text(
                      "Speech Rate",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Slider(
                    min: 0.0,
                    max: 1.0,
                    value: speechRate,
                    onChanged: (value) async {
                      setState(() {
                        speechRate = value;
                      });
                      // await flutterTts.setSpeechRate(speechRate);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      double.parse((speechRate).toStringAsFixed(2)).toString(),
                      style: const TextStyle(fontSize: 17),
                    ),
                  )
                ],
              ),
            ),
            */
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
