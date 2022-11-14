import 'package:alltalk_translate/providers.dart';
import 'package:alltalk_translate/widgets/translate_card.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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

  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();

  double volume = 1.0;
  double pitch = 1.0;
  double speechRate = 0.5;

  /*
  List<TranslateCard> translateCardList = [
    TranslateCard(cardKey: UniqueKey()),
    TranslateCard(cardKey: UniqueKey()),
  ];*/

  @override
  Widget build(BuildContext context) {
    // getLangs();

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
              children: createGridViewItems(),
            ),
            TextField(
              controller: _textController,
              onChanged: (value) {},
              onSubmitted: (value) {},
            ),
            ElevatedButton(
              onPressed: () {
                //   for (var translateCard in translateCardList) {
                //   translateCard.myText = _textController.text;
                //}
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

  List<Widget> createGridViewItems() {
    List<Widget> items = [];
    for (var card in ref.watch(translateCardListProvider)) {
      items.add(
        Dismissible(
          background: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ],
          ),
          key: card.cardKey,
          onDismissed: (direction) {
            setState(() {
              ref.watch(translateCardListProvider).removeWhere(
                    (element) => element.cardKey == card.cardKey,
                  );
            });
          },
          child: card,
        ),
      );
    }
    List<Widget> list = List.generate(
      ref.read(translateCardListProvider.notifier).state.length,
      (index) {
        return Dismissible(
          key:
              ref.read(translateCardListProvider.notifier).state[index].cardKey,
          onDismissed: (direction) {
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
          },
          child: ref.read(translateCardListProvider.notifier).state[index],
        );
      },
    );

    list.add(
      ElevatedButton(
        onPressed: () {
          //setState(() {
          //translateCardList.add(TranslateCard());
          // });
          //translateCardList.add(TranslateCard());
          ref
              .watch(translateCardListProvider)
              .add(TranslateCard(cardKey: UniqueKey()));
          setState(() {});
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );

    /*
    items.add(
      ElevatedButton(
        onPressed: () {
          //setState(() {
          //translateCardList.add(TranslateCard());
          // });
          //translateCardList.add(TranslateCard());
          ref
              .watch(translateCardListProvider)
              .add(TranslateCard(cardKey: UniqueKey()));
          setState(() {});
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
*/
    return list;
    return items;
  }

  getLangs() async {
    var langs = await flutterTts.getLanguages;
    print(langs);
  }
}
