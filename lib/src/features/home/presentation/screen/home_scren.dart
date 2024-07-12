import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart'
    show Scaffold, AppBar, BottomNavigationBar, FloatingActionButton;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:my_editor_app/src/features/authentication/presentation/provider/auth_provider.dart';
import 'package:my_editor_app/src/features/home/data/datasource/content_datasource.dart';
import 'package:my_editor_app/src/features/home/data/model/content_model.dart';
import 'package:my_editor_app/src/features/home/presentation/provider/content_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _folderNameController = TextEditingController();
  final TextEditingController _pageNameController = TextEditingController();
  bool _isFolderNameValid = false;
  bool _isPageNameValid = false;
  List<TreeViewItem> _treeViewItems = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _folderNameController.dispose();
    _pageNameController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  //function to build tree view items by using recursive
  List<TreeViewItem> _buildTreeViewItems(List<ContentModel> contentList) {
    return _buildTreeViewItemsRecursive(contentList);
  }

  List<TreeViewItem> _buildTreeViewItemsRecursive(
      List<ContentModel> contentList) {
    print('_buildTreeViewItemsRecursive');
    return contentList.map((content) {
      return TreeViewItem(
        lazy: true,
        content: Text(content.name),
        value: content,
        children: _buildTreeViewItemsRecursive(content.children ?? []),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(children: [
        Expanded(
            child: TreeView(
          narrowSpacing: true,
          shrinkWrap: true,
          items: _buildTreeViewItems(
              context.watch<ContentProvider>().currentContentList),
          onItemInvoked: (item, reason) async {
            ContentModel contentModel = item.value;
            int level = contentModel.level;
            int id = contentModel.id!;
            print(contentModel);
            print(level);
            print(id);
            String path = item.value.id.toString();

            if (item.parent != null) {
              var parent = item.parent;
              while (parent != null) {
                print('item.parent ${parent.value}');
                path = parent.value.id.toString() + "-" + path;
                parent = parent.parent;
              }
            } else {
              path = item.value.id.toString();
            }

            // reverse the path
            List<String> pathList = path.split('-');
            pathList = pathList.reversed.toList();
            path = pathList.join('-');

            print('path $path');
            if (item.children.isNotEmpty && item.value.id != 8) return;

            List<ContentModel>? children = await context
                .read<ContentProvider>()
                .listAllContentForSpecificFolder(level + 1, id);

            print(children);

            if (children != null) {
              context.read<ContentProvider>().addChildrenForParentId(children);
            }

            debugPrint('onItemInvoked: $item');
            print('reason: $reason');
            print(item.value);

            /*if (item.children.isNotEmpty) return;
            ContentModel contentModel = item.value;
            int level = contentModel.level;
            int id = contentModel.id!;
            print(contentModel);
            print(level);
            print(id);
            List<ContentModel>? children = await context
                .read<ContentProvider>()
                .listAllContentForSpecificFolder(level + 1, id);

            print(children);

            if (children != null) {
              context.read<ContentProvider>().addChildrenForParentId(children);
            }*/

            // If it's already populated, return.
          },
          onSelectionChanged: (selectedItems) async => debugPrint(
            'onSelectionChanged: ${selectedItems.map((i) => i.value)}',
          ),
          onSecondaryTap: (item, details) async {
            debugPrint('onSecondaryTap $item at ${details.globalPosition}');
          },
        )),
      ]),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isExpanded) ...[
            ScaleTransition(
              scale: _animation,
              child: FloatingActionButton(
                onPressed: () async {
                  final result = await showDialog<String?>(
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (context, setState) => ContentDialog(
                        title: const Text('Create new page'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextBox(
                              controller: _pageNameController,
                              placeholder: 'Enter page name',
                              onChanged: (value) {
                                setState(() {
                                  _isPageNameValid = value.isNotEmpty;
                                });
                              },
                            ),
                          ],
                        ),
                        actions: [
                          Button(
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.pop(context, null),
                          ),
                          FilledButton(
                            child: const Text('Confirm'),
                            onPressed: _isPageNameValid
                                ? () {
                                    Navigator.pop(
                                        context, _pageNameController.text);
                                    // Add page creation logic here
                                  }
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                  if (result != null) {
                    print(result);
                    int? res = await context.read<ContentProvider>().createPage(
                        name: result, parentId: null, content: null);
                    if (res != null) {
                      context.go('/page/$res');
                    }
                  }
                },
                child: Icon(FluentIcons.page),
              ),
            ),
            const SizedBox(height: 10),
            ScaleTransition(
              scale: _animation,
              child: FloatingActionButton(
                onPressed: () async {
                  final result = await showDialog<String?>(
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (context, setState) => ContentDialog(
                        title: const Text('Create new folder'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextBox(
                              controller: _folderNameController,
                              placeholder: 'Enter folder name',
                              onChanged: (value) {
                                setState(() {
                                  _isFolderNameValid = value.isNotEmpty;
                                });
                              },
                            ),
                          ],
                        ),
                        actions: [
                          Button(
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.pop(context, null),
                          ),
                          FilledButton(
                            child: const Text('Confirm'),
                            onPressed: _isFolderNameValid
                                ? () {
                                    Navigator.pop(
                                        context, _folderNameController.text);
                                    // Add folder creation logic here
                                  }
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );

                  if (result != null) {
                    print(result);
                    ContentModel? current;
                    if (context.read<ContentProvider>().currentIndex != -1 &&
                        context
                            .read<ContentProvider>()
                            .currentContentList[
                                context.read<ContentProvider>().currentIndex]
                            .isFolder) {
                      current =
                          context.read<ContentProvider>().currentContentList[
                              context.read<ContentProvider>().currentIndex];
                    }
                    int? parentId;
                    if (current != null) {
                      parentId = current.id;
                    }

                    print(parentId);
                    await context
                        .read<ContentProvider>()
                        .createFolder(name: result, parentId: parentId);
                  }
                },
                child: Icon(FluentIcons.folder),
              ),
            ),
            const SizedBox(height: 10),
          ],
          FloatingActionButton(
            onPressed: _toggleExpand,
            child: Icon(_isExpanded ? FluentIcons.cancel : FluentIcons.add),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(FluentIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(FluentIcons.group), label: 'Team'),
          BottomNavigationBarItem(
              icon: Icon(FluentIcons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}
