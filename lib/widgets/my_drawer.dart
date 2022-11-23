import 'package:alltalk_translate/all_talk_icons_icons.dart';
import 'package:alltalk_translate/color_consts.dart';
import 'package:alltalk_translate/main.dart';
import 'package:alltalk_translate/providers.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:animated_switch/animated_switch.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider_nnbd/flutter_fluid_slider_nnbd.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulHookConsumerWidget {
  const MyDrawer({super.key});

  @override
  ConsumerState<MyDrawer> createState() => _MyDrawer();
}

class _MyDrawer extends ConsumerState<MyDrawer> {
  FlutterTts flutterTts = FlutterTts();
  double headerSize = 36;
  double soundSettingsTextSize = 16;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Color primaryColor = Theme.of(context).primaryColor;
    Color backgroundColor = Theme.of(context).backgroundColor;
    Brightness brightness = Theme.of(context).brightness;

    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.fromLTRB(8, height / 40, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedIconButton(
              icons: const [
                AnimatedIconItem(
                  icon: Icon(
                    AllTalkIcons.sun,
                  ),
                ),
                AnimatedIconItem(
                  icon: Icon(
                    AllTalkIcons.sun_filled,
                  ),
                ),
              ],
              onPressed: () {
                if (brightness == Brightness.dark) {
                  MyApp.of(context).changeTheme(ThemeMode.light);
                } else {
                  MyApp.of(context).changeTheme(ThemeMode.dark);
                }
              },
            ),
            IconButton(
              onPressed: () {
                if (brightness == Brightness.dark) {
                  MyApp.of(context).changeTheme(ThemeMode.light);
                } else {
                  MyApp.of(context).changeTheme(ThemeMode.dark);
                }
              },
              icon: brightness == Brightness.dark
                  ? const Icon(
                      AllTalkIcons.sun,
                    )
                  : const Icon(
                      AllTalkIcons.sun_filled,
                    ),
            ),

            // profile
            Container(
              height: height / 6,
              child: Row(
                children: [
                  // profile image
                  const CircleAvatar(
                    maxRadius: 52,
                    child: CircleAvatar(
                      radius: 52,
                      backgroundColor: ColorConsts.myBlue,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/logo/logo.png"),
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
                              fontSize: headerSize, color: backgroundColor),
                        ),

                        // social media icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // github
                            AnimatedIconButton(
                              icons: const [
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
                              icons: const [
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
                              icons: const [
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // volume
                Text(
                  "Volume",
                  style: TextStyle(
                    fontSize: soundSettingsTextSize,
                    color: backgroundColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                    color: backgroundColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                    color: backgroundColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                createFluidSlider(
                  0.1,
                  1.0,
                  AllTalkIcons.clock,
                  speechRateProvider.notifier,
                ),
                const SizedBox(
                  height: 20,
                ),

                // reset
                Column(
                  children: [
                    AnimatedIconButton(
                      icons: const [
                        AnimatedIconItem(
                          icon: Icon(
                            AllTalkIcons.arrows_cw,
                            size: 32,
                          ),
                        ),
                      ],
                      onPressed: () {
                        setState(() {
                          ref.read(volumeProvider.notifier).state = 1.0;
                          ref.read(pitchProvider.notifier).state = 1.0;
                          ref.read(speechRateProvider.notifier).state = 0.5;
                        });
                      },
                    ),
                    Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: soundSettingsTextSize,
                        color: backgroundColor,
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
        sliderColor: ColorConsts.myRed,
        thumbColor: Theme.of(context).primaryColor,
        labelsTextStyle: TextStyle(
          color: Theme.of(context).backgroundColor,
        ),
        showDecimalValue: true,
        start: Icon(
          icon,
          color: Colors.white,
        ),
        min: min,
        max: max,
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
    Color primaryColor = Theme.of(context).primaryColor;
    Color backgroundColor = Theme.of(context).backgroundColor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
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
                      "Sa! \n\n Klilcdaroglu aday olmasin.",
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
              children: [
                Icon(
                  AllTalkIcons.info_outline,
                  color: backgroundColor,
                  size: 14,
                ),
                Text(
                  "About",
                  style: TextStyle(
                    color: backgroundColor,
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
    );
  }
}
