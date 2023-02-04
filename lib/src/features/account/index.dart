import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/features/auth/log_in.dart';
import 'package:flutter_base/src/services/helpers.dart';
import 'package:flutter_base/src/widgets/list_tile_icon.dart';
import 'package:flutter_base/src/widgets/page_title_icon.dart';
import 'package:flutter_base/src/widgets/list_tile_profile.dart';

class Account extends StatelessWidget {
  const Account({
    super.key,
    required this.mainContext,
  });

  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            pageTitleIcon(
              context: context,
              title: "Account",
              icon: const Icon(
                CupertinoIcons.person_fill,
                size: 24,
              ),
            ),
            // PROFILE
            listTileProfile(context: context),
            // SETTINGS
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Theme
            listTileIcon(
              context: context,
              icon: isDarkTheme(context)
                  ? CupertinoIcons.moon_fill
                  : CupertinoIcons.sun_max_fill,
              title: "Theme",
              onTap: () => selectThemeMode(context),
            ),
            // Admin Dashboard
            listTileIcon(
              context: context,
              icon: CupertinoIcons.chart_bar_alt_fill,
              title: "Admin Dashboard",
              onTap: () {},
            ),
            // Security (Password, Login activity)
            listTileIcon(
              context: context,
              icon: CupertinoIcons.padlock,
              title: "Security",
              onTap: () {},
            ),
            // Log Out
            ListTile(
              title: Text(
                'Log Out',
                style: TextStyle(color: Colors.red[400]),
              ),
              onTap: () => Navigator.of(mainContext).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LogIn(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
