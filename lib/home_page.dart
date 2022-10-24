import 'package:alltalk_translate/providers.dart';
import 'package:alltalk_translate/widgets/change_language_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late TextEditingController _textController;
  FlutterTts flutterTts = FlutterTts();

  double volume = 1.0;
  double pitch = 1.0;
  double speechRate = 0.5;
  List<String>? languages;

  String _text = "";

  @override
  void initState() {
    super.initState();
    init();
    _textController = TextEditingController();
  }

  void init() async {
    languages = List<String>.from(await flutterTts.getLanguages);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    int textFieldLineCount = (screenHeight / 50).toInt();
    print(screenHeight);
    return Scaffold(
      appBar: AppBar(title: const Text("Text")),
      body: SingleChildScrollView(
        child: Column(children: [
          Text("${ref.watch(langCodeProvider)} text"),
          // Text field
          Row(
            children: [
              // Text field
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        maxLines: textFieldLineCount,
                        minLines: textFieldLineCount,
                        controller: _textController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: "Write message...",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          _text = value.toString();
                        },
                        onSubmitted: (value) async {
                          // _textController.clear();
                          _speak();
                        },
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        maxLines: textFieldLineCount,
                        minLines: textFieldLineCount,
                        controller: _textController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: "Write message...",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          _text = value.toString();
                        },
                        onSubmitted: (value) async {
                          // _textController.clear();
                          _speak();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ChangeLanguageButton(languages: languages),

              // ilerde buraya basinca diller degissin
              const Icon(Icons.keyboard_double_arrow_right_outlined),
              ChangeLanguageButton(languages: languages),
            ],
          ),

          // speak-stop button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
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
                      double.parse((volume).toStringAsFixed(2)).toString(),
                      style: const TextStyle(fontSize: 17)),
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
                    await flutterTts.setPitch(pitch);
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
        ]),
      ),
    );
  }

  void initSetting() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.setLanguage(ref.read(langCodeProvider.notifier).state);
  }

  void _speak() async {
    initSetting();
    await flutterTts.speak(_textController.text);
  }

  void _stop() async {
    await flutterTts.stop();
  }
}
