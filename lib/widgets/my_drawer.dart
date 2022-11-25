import 'package:alltalk_translate/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:alltalk_translate/all_talk_icons_icons.dart';
import 'package:alltalk_translate/color_consts.dart';
import 'package:alltalk_translate/main.dart';
import 'package:alltalk_translate/providers.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
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
            // profile
            Column(
              children: [
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
                            backgroundImage:
                                AssetImage("assets/logos/logo.png"),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // social media icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // lang change
                    IconButton(
                      onPressed: () {
                        if (context.locale == Locale("tr")) {
                          context.setLocale(Locale("en"));
                        } else {
                          context.setLocale(Locale("tr"));
                        }
                      },
                      icon: const Icon(Icons.language),
                    ),

                    // github
                    createSocialMediaIcon(
                        AllTalkIcons.github, "https://github.com/Keyvan14162"),

                    // linkedin
                    createSocialMediaIcon(AllTalkIcons.linkedin,
                        "https://www.linkedin.com/in/ismail-keyvan/"),

                    // gmail
                    createSocialMediaIcon(AllTalkIcons.mail,
                        "mailto:ismailkyvsn2000@gmail.com?subject=Hello%20!&body="),

                    // play store vote
                    createSocialMediaIcon(AllTalkIcons.star_filled,
                        "https://play.google.com/store/apps/details?id=com.ismailkeyvan.aktuel_urunler_bim_a101_sok"),

                    // dark - light mode
                    Flexible(
                      child: AnimatedIconButton(
                        icons: const [
                          AnimatedIconItem(
                            icon: Icon(
                              AllTalkIcons.sun,
                            ),
                          ),
                          AnimatedIconItem(
                            icon: Icon(
                              AllTalkIcons.moon,
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
                    ),
                  ],
                ),
              ],
            ),

            // sound settings
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // volume
                Text(
                  LocaleKeys.volume.tr(),
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
                  LocaleKeys.pitch.tr(),
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
                  LocaleKeys.speech_rate.tr(),
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
                      LocaleKeys.reset.tr(),
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
            createAbout(primaryColor, backgroundColor),
          ],
        ),
      ),
    );
  }

  createSocialMediaIcon(IconData iconData, String url) {
    return Flexible(
      child: AnimatedIconButton(
        icons: [
          AnimatedIconItem(
            icon: Icon(
              iconData,
              size: 24,
            ),
          ),
        ],
        onPressed: () async {
          if (!await launchUrl(Uri.parse(url),
              mode: LaunchMode.externalApplication)) {
            throw "Could not launch ";
          }
        },
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

  createAbout(Color primaryColor, Color backgroundColor) {
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
                    content: Text(
                      "${LocaleKeys.about_first_part.tr()} \n\n ${LocaleKeys.about_second_part.tr()}",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(LocaleKeys.ok.tr()),
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
                  LocaleKeys.about.tr(),
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
