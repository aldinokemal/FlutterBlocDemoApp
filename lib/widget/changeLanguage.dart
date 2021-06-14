import 'package:flutter/material.dart';
import 'package:my_app/config/theme.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      animate: false,
      minWidth: 90.0,
      initialLabelIndex: context.locale.languageCode == "id" ? 0 : 1,
      cornerRadius: 10.0,
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      totalSwitches: 2,
      labels: ['ID', 'EN'],
      // icons: [FontAwesomeIcons.mars, FontAwesomeIcons.venus],
      activeBgColors: [
        [AppTheme.main1],
        [AppTheme.main1],
      ],
      onToggle: (index) async {
        switch (index) {
          case 0:
            await context.setLocale(Locale("id"));
            break;
          case 1:
            await context.setLocale(Locale("en"));
            break;
        }
        print('switched to: $index');
      },
    );
  }
}
