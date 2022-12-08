import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_dorm/auth/bloc/auth_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_event.dart';

class Language {
  Locale locale;
  String langName;

  Language({
    required this.locale,
    required this.langName,
  });
}

class AboutPage extends StatefulWidget {
  final SharedPreferences prefs;

  const AboutPage(this.prefs, {super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    String roomId = widget.prefs.getString('roomId')!;
    AuthBloc bloc = context.read<AuthBloc>();

    List<Language> languageList = [
      Language(
        langName: 'English',
        locale: const Locale('en'),
      ),
      Language(
        langName: 'Russian',
        locale: const Locale('ru'),
      )
    ];
    Language? selectedLang;
    selectedLang = languageList.singleWhere((e) => e.locale == context.locale);

    return Scaffold(
      appBar: AppBar(
        title: Text("about_page_bar".tr()),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 10),
            alignment: Alignment.topCenter,
            child: SelectableText(
              "invite_room".tr(args: [roomId]),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () => bloc.add(LeaveRoomEvent()),
              child:  Text("leave_room".tr()),
            ),
          ),

          // toggle light/dark theme
          Row(
            children: [
              Expanded(
                  child: TextButton(
                      onPressed: () => AdaptiveTheme.of(context).setDark(),
                      child:  Text('dark_mode'.tr()))),
              Expanded(
                child: TextButton(
                  onPressed: () => AdaptiveTheme.of(context).setLight(),
                  child:  Text('light_mode'.tr()),
                ),
              ),
            ],
          ),

          DropdownButton<Language>(
            iconSize: 18,
            elevation: 16,
            value: selectedLang,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              padding: const EdgeInsets.only(left: 4, right: 4),
              color: Colors.transparent,
            ),
            onChanged: (newValue) {
              setState(() {
                selectedLang = newValue!;
              });
              if (newValue!.locale.toString() == 'ru') {
                context.setLocale(const Locale('ru'));
              } else {
                context.setLocale(const Locale("en"));
              }
            },
            items:
                languageList.map<DropdownMenuItem<Language>>((Language value) {
              return DropdownMenuItem<Language>(
                value: value,
                child: Text(
                  value.langName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
