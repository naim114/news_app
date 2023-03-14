import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/services/helpers.dart';
import 'package:flutter_base/src/widgets/list_tile_notification.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../widgets/page_title_icon.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 25,
              left: 25,
              right: 25,
              bottom: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pageTitleIcon(
                  context: context,
                  title: "Notification",
                  icon: const Icon(
                    CupertinoIcons.bell_fill,
                    size: 24,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'View all your notifications. Slide notification for action.',
                    style: TextStyle(),
                  ),
                ),
              ],
            ),
          ),

          // FOREACH HERE
          listTileNotification(
            onDelete: doNothing,
            onTap: () {},
            unread: false,
          ),
        ],
      ),
    );
  }
}

void doNothing(BuildContext context) {}