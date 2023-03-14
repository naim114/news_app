import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../services/helpers.dart';

Widget listTileNotification({
  required void Function(BuildContext) onDelete,
  required void Function() onTap,
  bool unread = true,
}) =>
    GestureDetector(
      onTap: onTap,
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: onDelete,
              backgroundColor: CustomColor.danger,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          shape: const Border(
            bottom: BorderSide(
              color: CustomColor.neutral2,
            ),
          ),
          title: const Text(
            'Notifications title',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text('Mar 18 2014'),
          trailing: (unread)
              ? const Icon(
                  Icons.circle,
                  size: 10,
                  color: CustomColor.secondary,
                )
              : const SizedBox.shrink(),
        ),
      ),
    );