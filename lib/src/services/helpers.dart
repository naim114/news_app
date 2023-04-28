import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/model/news_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:theme_mode_handler/theme_picker_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../widgets/list_tile/list_tile_comment.dart';

class CustomColor {
  static const primary = Color(0xFF643FDB);
  static const secondary = Color(0xFFFF8A00);
  static const neutral1 = Color(0xFF1C1243);
  static const neutral2 = Color(0xFFA29EB6);
  static const neutral3 = Color(0xFFEFF1F3);
  static const danger = Color(0xFFFE4A49);
  static const success = Color(0xFF47C272);
}

bool isDarkTheme(context) {
  return Theme.of(context).brightness == Brightness.dark ? true : false;
}

Color getColorByBackground(context) {
  return isDarkTheme(context) ? Colors.white : CustomColor.neutral1;
}

void selectThemeMode(BuildContext context) async {
  final newThemeMode = await showThemePickerDialog(context: context);
  debugPrint(newThemeMode.toString());
}

Future<void> goToURL({
  required Uri url,
  required BuildContext context,
}) async {
  if (!await launchUrl(url)) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Could not launch $url'),
    ));
    throw Exception('Could not launch $url');
  }
}

bool validateEmail(TextEditingController emailController) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return regex.hasMatch(emailController.text);
}

bool validatePassword(TextEditingController passwordController) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  return regex.hasMatch(passwordController.text);
}

extension ListExtension<E> on List<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) {
    return Map.fromEntries(
      groupByMapEntries(keyFunction),
    );
  }

  Iterable<MapEntry<K, List<E>>> groupByMapEntries<K>(
      K Function(E) keyFunction) sync* {
    final groups = <K, List<E>>{};
    for (final element in this) {
      final key = keyFunction(element);
      if (!groups.containsKey(key)) {
        groups[key] = <E>[];
      }
      groups[key]!.add(element);
    }
    yield* groups.entries;
  }
}

Future<File?> downloadFile(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }
  return null;
}

void showComment(
  BuildContext context,
  NewsModel news,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isDarkTheme(context)
              ? CupertinoColors.darkBackgroundGray
              : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //  Header
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                width: 40,
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 4.0,
                ),
                decoration: const BoxDecoration(
                  color: CupertinoColors.systemGrey,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: const SizedBox(
                  height: 5,
                ),
              ),
            ),
            Text(
              "Comments",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: getColorByBackground(context),
                fontSize: 16,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                color: Colors.grey,
                height: 1,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
            ),
            //  Comments Section
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    listTileComment(context: context),
                    listTileComment(context: context),
                    listTileComment(context: context),
                  ],
                ),
              ),
            ),
            // Input
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: isDarkTheme(context)
                        ? CupertinoColors.darkBackgroundGray
                        : Colors.white,
                    hintText: 'Enter comment here',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        // TODO send commend
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
