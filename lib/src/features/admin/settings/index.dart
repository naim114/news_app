import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/widgets/scaffold/edit_text.dart';

import '../../../services/helpers.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColor.neutral2,
          ),
        ),
        title: Text(
          "Application Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getColorByBackground(context),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Application name"),
            trailing: const Text("Application name"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditText(
                  appBarTitle: 'Edit Application Name',
                  textFieldLabel: 'Application Name',
                  onCancel: () => Navigator.pop(context),
                  onConfirm: () {},
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text("Copyright URL"),
            trailing: const Text("https://github.com/naim114"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditText(
                  appBarTitle: 'Edit Copyright URL',
                  textFieldLabel: 'Copyright URL',
                  onCancel: () => Navigator.pop(context),
                  onConfirm: () {},
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text("Privacy Policy URL"),
            trailing: const Text("https://github.com/naim114"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditText(
                  appBarTitle: 'Edit Privacy Policy URL',
                  textFieldLabel: 'Privacy Policy URL',
                  onCancel: () => Navigator.pop(context),
                  onConfirm: () {},
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text("Terms & Condition URL"),
            trailing: const Text("https://github.com/naim114"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditText(
                  appBarTitle: 'Edit Terms & Condition URL',
                  textFieldLabel: 'Terms & Condition URL',
                  onCancel: () => Navigator.pop(context),
                  onConfirm: () {},
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text("Logo"),
            trailing: const Text(
              "Tap to change logo",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Primary color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.primary),
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Secondary color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.secondary),
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Neutral 1 color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.neutral1),
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Neutral 2 color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.neutral2),
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Neutral 3 color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.neutral3),
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Semantic 1 color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.semantic1),
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Semantic 2 color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.semantic2),
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Danger color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.danger),
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Success color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.success),
                ),
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}