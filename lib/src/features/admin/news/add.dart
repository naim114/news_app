import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_base/src/services/news_services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:fluttertoast/fluttertoast.dart';
import '../../../model/user_model.dart';
import '../../../widgets/editor/news_editor.dart';

class AddNews extends StatelessWidget {
  const AddNews({super.key, required this.currentUser});
  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    final controller = QuillController(
      document: Document()..insert(0, 'Write your article here'),
      selection: const TextSelection.collapsed(offset: 0),
    );

    return NewsEditor(
      context: context,
      controller: controller,
      appBarTitle: "Add News",
      onPost: (quillController, thumbnailFile, title) async {
        if (thumbnailFile != null) {
          final result = await NewsService().add(
            title: title,
            jsonContent:
                jsonEncode(quillController.document.toDelta().toJson()),
            author: currentUser,
            imageFile: thumbnailFile,
          );

          if (result == true && context.mounted) {
            Fluttertoast.showToast(msg: "News posted");
            Navigator.pop(context);
          }
        } else {
          final result = await NewsService().add(
            title: title,
            jsonContent:
                jsonEncode(quillController.document.toDelta().toJson()),
            author: currentUser,
          );

          if (result == true && context.mounted) {
            Fluttertoast.showToast(msg: "News posted");
            Navigator.pop(context);
          }
        }
      },
    );
  }
}
