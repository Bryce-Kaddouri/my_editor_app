import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Scaffold, AppBar;
import 'package:my_editor_app/src/features/home/data/model/content_model.dart';
import 'package:my_editor_app/src/features/home/presentation/provider/content_provider.dart';
import 'package:provider/provider.dart';

class PageScreen extends StatefulWidget {
  final int id;
  PageScreen({super.key, required this.id});

  @override
  _PageScreenState createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  late EditorState editorState;

  @override
  void initState() {
    super.initState();
    ContentModel contentModel = context
        .read<ContentProvider>()
        .currentContentList[0]
        .firstWhere((element) => element.id == widget.id);
    if (contentModel.content != null) {
      editorState = EditorState(document: 
          Document.fromJson(contentModel.content as Map<String, dynamic>));
    } else {
      editorState = EditorState.blank(withInitialText: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page ${widget.id}'),
        actions: [
          IconButton(
            icon: Icon(FluentIcons.save),
            onPressed: () {
              print("save");

              ContentModel contentModel = context
                  .read<ContentProvider>()
                  .currentContentList[0]
                  .firstWhere((element) => element.id == widget.id);
              contentModel.content = editorState.document.toJson();
              print(contentModel.toJson());
              context.read<ContentProvider>().updateContent(contentModel);
            },
          )
        ],
      ),
      body: Container(
        color: Colors.red,
        width: double.infinity,
        height: double.infinity,
        child: AppFlowyEditor(
          editorState: editorState,
        ),
      ),
    );
  }
}
