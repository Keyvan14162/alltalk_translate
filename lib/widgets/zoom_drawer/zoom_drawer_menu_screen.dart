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
  double headerSize = 36;
  double soundSettingsTextSize = 16;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.fromLTRB(8, height / 40, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // profile
          Container(
            height: height / 6,
            child: Row(
              children: [
                // profile image
                CircleAvatar(
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
                const SizedBox(
                  width: 10,
                ),
                // header and icons
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // kendin bi tane icon yapabilin
                      Text(
                        "AllTalk",
                        style: TextStyle(
                          fontSize: headerSize,
                        ),
                      ),

                      // social media icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // github
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

                          // linkedin
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

                          // gmail
                          AnimatedIconButton(
                            icons: [
                              AnimatedIconItem(
                                icon: Icon(
                                  AllTalkIcons.mail,
                                  size: 24,
                                ),
                              ),
                            ],
                            onPressed: () async {
                              if (!await launchUrl(
                                  Uri.parse(
                                      "mailto:ismailkyvsn2000@gmail.com?subject=Hello%20!&body="),
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
              Text(
                "Volume",
                style: TextStyle(
                  fontSize: soundSettingsTextSize,
                ),
              ),
              createFluidSlider(
                0.0,
                1.0,
                AllTalkIcons.volume_high,
                volumeProvider.notifier,
              ),

              const SizedBox(
                height: 20,
              ),

              // pitch
              Text(
                "Pitch",
                style: TextStyle(
                  fontSize: soundSettingsTextSize,
                ),
              ),
              createFluidSlider(
                0.5,
                2.0,
                AllTalkIcons.mic_outline,
                pitchProvider.notifier,
              ),

              const SizedBox(
                height: 20,
              ),

              // speech rate
              Text(
                "SpeechRate",
                style: TextStyle(
                  fontSize: soundSettingsTextSize,
                ),
              ),
              createFluidSlider(
                0.1,
                1.0,
                AllTalkIcons.clock,
                speechRateProvider.notifier,
              ),

              // reset
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade400),
                      onPressed: () {
                        setState(() {
                          ref.read(volumeProvider.notifier).state = 1.0;
                          ref.read(pitchProvider.notifier).state = 1.0;
                          ref.read(speechRateProvider.notifier).state = 0.5;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
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

          SizedBox(
            height: height / 12,
          ),

          // About
          const About(),
        ],
      ),
    );
  }

  createFluidSlider(
    double min,
    double max,
    IconData icon,
    AlwaysAliveRefreshable<StateController<double>> notifier,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
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

class About extends StatelessWidget {
  const About({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    "Sa! \n\n İyi alışverişler dileriz...",
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
                AllTalkIcons.info_outline,
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
    );
  }
}
