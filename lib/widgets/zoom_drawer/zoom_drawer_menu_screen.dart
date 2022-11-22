import 'package:alltalk_translate/all_talk_icons_icons.dart';
import 'package:alltalk_translate/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ZoomDrawerMenuScreen extends StatefulHookConsumerWidget {
  const ZoomDrawerMenuScreen({super.key});

  @override
  ConsumerState<ZoomDrawerMenuScreen> createState() =>
      _ZoomDrawerMenuScreenState();
}

class _ZoomDrawerMenuScreenState extends ConsumerState<ZoomDrawerMenuScreen> {
  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // profile image
            CircleAvatar(
              maxRadius: 42,
              child: CircleAvatar(
                radius: 42,
                backgroundColor: Theme.of(context).primaryColor,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    "https://github.com/Keyvan14162.png",
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ismail Keyvan",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "ismailkyvsn2000@gmail.com",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // sound settings
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // volume
            Text("Volume"),
            Row(
              children: [
                Slider(
                  min: 0.0,
                  max: 1.0,
                  value: ref.read(volumeProvider.notifier).state,
                  onChanged: (value) {
                    setState(() {
                      ref.read(volumeProvider.notifier).state = value;
                    });
                  },
                ),
                Text(ref.watch(volumeProvider).toStringAsFixed(2).toString()),
              ],
            ),

            // pitch
            Text("Pitch"),
            Row(
              children: [
                Slider(
                  min: 0.5,
                  max: 2.0,
                  value: ref.read(pitchProvider.notifier).state,
                  onChanged: (value) {
                    setState(() {
                      ref.read(pitchProvider.notifier).state = value;
                    });
                  },
                ),
                Text(ref.watch(pitchProvider).toStringAsFixed(2).toString()),
              ],
            ),

            // speech rate
            Text("Speech Rate"),
            Row(
              children: [
                Slider(
                  min: 0.1,
                  max: 1.0,
                  value: ref.read(speechRateProvider.notifier).state,
                  onChanged: (value) {
                    setState(() {
                      ref.read(speechRateProvider.notifier).state = value;
                    });
                  },
                ),
                Text(ref
                    .watch(speechRateProvider)
                    .toStringAsFixed(2)
                    .toString()),
              ],
            ),

            // reset
            ElevatedButton(
              onPressed: () {
                setState(() {
                  ref.read(volumeProvider.notifier).state = 1.0;
                  ref.read(pitchProvider.notifier).state = 1.0;
                  ref.read(speechRateProvider.notifier).state = 0.5;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Reset Settings"),
                  Icon(AllTalkIcons.arrows_cw),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
