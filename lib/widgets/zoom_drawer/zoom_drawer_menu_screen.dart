import 'package:alltalk_translate/all_talk_icons_icons.dart';
import 'package:alltalk_translate/providers.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_fluid_slider_nnbd/flutter_fluid_slider_nnbd.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // profile
          Container(
            height: MediaQuery.of(context).size.height / 6,
            child: Row(
              children: [
                // profile image
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    maxRadius: 52,
                    child: CircleAvatar(
                      radius: 52,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          "https://github.com/Keyvan14162.png",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // kendin bi tane icon yapabilin
                      Text(
                        "AllTalk",
                        style: TextStyle(
                          fontSize: 36,
                        ),
                      ),

                      // social media icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedIconButton(
                            icons: [
                              AnimatedIconItem(
                                icon: Icon(
                                  AllTalkIcons.github,
                                  size: 24,
                                ),
                              ),
                            ],
                            onPressed: () async {
                              if (!await launchUrl(
                                  Uri.parse("https://github.com/Keyvan14162"),
                                  mode: LaunchMode.externalApplication)) {
                                throw "Could not launch ";
                              }
                            },
                          ),
                          AnimatedIconButton(
                            icons: [
                              AnimatedIconItem(
                                icon: Icon(
                                  AllTalkIcons.linkedin,
                                  size: 24,
                                ),
                              ),
                            ],
                            onPressed: () async {
                              if (!await launchUrl(
                                  Uri.parse(
                                      "https://www.linkedin.com/in/ismail-keyvan/"),
                                  mode: LaunchMode.externalApplication)) {
                                throw "Could not launch ";
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // sound settings
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // volume
              Text("Volume"),
              createFluidSlider(
                Colors.pinkAccent,
                Colors.amber,
                0.0,
                1.0,
                AllTalkIcons.volume_high,
                volumeProvider.notifier,
              ),

              SizedBox(
                height: 20,
              ),
              // pitch
              Text("Pitch"),
              createFluidSlider(
                Colors.pinkAccent,
                Colors.amber,
                0.5,
                2.0,
                AllTalkIcons.mic_outline,
                pitchProvider.notifier,
              ),

              SizedBox(
                height: 20,
              ),

              // speech rate
              Text("Speech Rate"),
              createFluidSlider(
                Colors.pinkAccent,
                Colors.amber,
                0.1,
                1.0,
                AllTalkIcons.clock,
                speechRateProvider.notifier,
              ),

              // reset
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: ElevatedButton(
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
                  ),
                ],
              ),
            ],
          ),

          // bottom link part
          // hakkinda
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Center(
                          child: Text(
                            "AllTalk",
                          ),
                        ),
                        content: const Text(
                          "Bim, A101 ve Şok marketleri aktüel kataloglarını canlı olarak takip edebilmeniz için geliştirilmiş bir uygulamadır. Uygulama kişisel verilerinize erişim izni istemez, kişisel verilerinizi göremez, kullanamaz yada değiştiremez. Uygulamamıza destek vermek için yorum yapmayı ve puanlamayı unutmayınız!\n\n İyi alışverişler dileriz...",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Ok"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.info_outline,
                      color: Colors.black,
                      size: 14,
                    ),
                    Text(
                      "About",
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1.6,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  createFluidSlider(
    Color sliderColor,
    Color thumbColor,
    double min,
    double max,
    IconData icon,
    AlwaysAliveRefreshable<StateController<double>> notifier,
  ) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width / 1.5,
      child: FluidSlider(
        sliderColor: Colors.red.shade400,
        thumbColor: Colors.white,
        showDecimalValue: true,
        start: Icon(
          icon,
          color: Colors.white,
        ),
        min: 0.1,
        max: 1.0,
        value: ref.read(notifier).state,
        onChanged: (value) {
          setState(() {
            ref.read(notifier).state = value;
          });
        },
      ),
    );
  }
}
