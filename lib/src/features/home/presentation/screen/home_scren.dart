import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart'
    show Scaffold, AppBar, BottomNavigationBar, FloatingActionButton;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:my_editor_app/src/features/authentication/presentation/provider/auth_provider.dart';
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

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(children: [
       
        TreeView(
          shrinkWrap: true,
          items: [
            TreeViewItem(
              content: const Text('Item with lazy loading'),
              value: 'lazy_load',
              // This means the item will be expandable, although there are no
              // children yet.
              lazy: true,
              // Ensure the list is modifiable.
              children: [],
              onExpandToggle: (item, getsExpanded) async {
                // If it's already populated, return.
                if (item.children.isNotEmpty) return;

                // Do your fetching...
                await Future.delayed(const Duration(seconds: 2));

                // ...and add the fetched nodes.
                item.children.addAll([
                  TreeViewItem(
                    content: const Text('Lazy item 1'),
                    value: 'lazy_1',
                  ),
                  TreeViewItem(
                    content: const Text('Lazy item 2'),
                    value: 'lazy_2',
                  ),
                  TreeViewItem(
                    content: const Text('Lazy item 3'),
                    value: 'lazy_3',
                  ),
                  TreeViewItem(
                    content: const Text(
                      'Lazy item 4 (this text should not overflow)',
                      overflow: TextOverflow.ellipsis,
                    ),
                    value: 'lazy_4',
                  ),
                ]);
              },
            ),
            TreeViewItem(
              content: const Text('Item with lazy loading'),
              value: 'lazy_load',
              // This means the item will be expandable, although there are no
              // children yet.
              lazy: true,
              // Ensure the list is modifiable.
              children: [],
              onExpandToggle: (item, getsExpanded) async {
                // If it's already populated, return.
                if (item.children.isNotEmpty) return;

                // Do your fetching...
                await Future.delayed(const Duration(seconds: 2));

                // ...and add the fetched nodes.
                item.children.addAll([
                  TreeViewItem(
                    content: const Text('Lazy item 1'),
                    value: 'lazy_1',
                  ),
                  TreeViewItem(
                    content: const Text('Lazy item 2'),
                    value: 'lazy_2',
                  ),
                  TreeViewItem(
                    content: const Text('Lazy item 3'),
                    value: 'lazy_3',
                  ),
                  TreeViewItem(
                    content: const Text(
                      'Lazy item 4 (this text should not overflow)',
                      overflow: TextOverflow.ellipsis,
                    ),
                    value: 'lazy_4',
                  ),
                ]);
              },
            ),
            TreeViewItem(
              content: const Text('Item with lazy loading'),
              value: 'lazy_load',
              // This means the item will be expandable, although there are no
              // children yet.
              lazy: true,
              // Ensure the list is modifiable.
              children: [],
              onExpandToggle: (item, getsExpanded) async {
                // If it's already populated, return.
                if (item.children.isNotEmpty) return;

                // Do your fetching...
                await Future.delayed(const Duration(seconds: 2));

                // ...and add the fetched nodes.
                item.children.addAll([
                  TreeViewItem(
                    content: const Text('Lazy item 1'),
                    value: 'lazy_1',
                  ),
                  TreeViewItem(
                    content: const Text('Lazy item 2'),
                    value: 'lazy_2',
                  ),
                  TreeViewItem(
                    content: const Text('Lazy item 3'),
                    value: 'lazy_3',
                  ),
                  TreeViewItem(
                    content: const Text(
                      'Lazy item 4 (this text should not overflow)',
                      overflow: TextOverflow.ellipsis,
                    ),
                    value: 'lazy_4',
                  ),
                ]);
              },
            ),
          ],
          onItemInvoked: (item, reason) async =>
              debugPrint('onItemInvoked: $item'),
          onSelectionChanged: (selectedItems) async => debugPrint(
            'onSelectionChanged: ${selectedItems.map((i) => i.value)}',
          ),
          onSecondaryTap: (item, details) async {
            debugPrint('onSecondaryTap $item at ${details.globalPosition}');
          },
        )

        /*context.watch<ContentProvider>().contentList.isNotEmpty
            ? TreeView(
                shrinkWrap: true,
                items: <TreeViewItem>[
                  ...context
                      .watch<ContentProvider>()
                      .contentList
                      .where((element) => element.childId == null)
                      .map(
                        (e) => TreeViewItem(
                          lazy: true,
                          onExpandToggle: (item, getsExpanded) async {
                            // If it's already populated, return.
                            if (item.children.isNotEmpty) return;

                            // Do your fetching...
                            await Future.delayed(const Duration(seconds: 2));

                            // ...and add the fetched nodes.
                            item.children.addAll([
                              TreeViewItem(
                                content: const Text('Lazy item 1'),
                                value: 'lazy_1',
                              ),
                              TreeViewItem(
                                content: const Text('Lazy item 2'),
                                value: 'lazy_2',
                              ),
                              TreeViewItem(
                                content: const Text('Lazy item 3'),
                                value: 'lazy_3',
                              ),
                              TreeViewItem(
                                content: const Text(
                                  'Lazy item 4 (this text should not overflow)',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                value: 'lazy_4',
                              ),
                            ]);
                          },
                          backgroundColor:
                              context.watch<ContentProvider>().currentIndex ==
                                      e.id
                                  ? ButtonState.all(FluentTheme.of(context)
                                      .micaBackgroundColor
                                      .withOpacity(1))
                                  : ButtonState.all(FluentTheme.of(context)
                                      .micaBackgroundColor
                                      .withOpacity(0.7)),
                          selected:
                              context.watch<ContentProvider>().currentIndex ==
                                  e.id,
                          children: [],
                          onInvoked: (item, reason) async {
                            context
                                .read<ContentProvider>()
                                .setCurrentIndex(e.id!);
                          },
                          leading: Icon(e.isFolder
                              ? FluentIcons.folder
                              : FluentIcons.page),
                          content: Row(
                            children: [
                              Expanded(child: Text(e.name)),
                              if (context
                                      .watch<ContentProvider>()
                                      .currentIndex ==
                                  e.id) ...[
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: () {
                                    if (e.isFolder) {
                                      print("folder");
                                    } else {
                                      context.go('/page/${e.id}');
                                    }
                                  },
                                  icon: Icon(FluentIcons.forward),
                                ),
                              ],
                            ],
                          ),
                          value: e.id,
                        ),
                      ),
                ],
              )
            : const Center(child: ProgressRing())*/
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
                    int? res = await context
                        .read<ContentProvider>()
                        .createPage(name: result, childId: null, content: null);
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
                            .contentList[
                                context.read<ContentProvider>().currentIndex]
                            .isFolder) {
                      current = context.read<ContentProvider>().contentList[
                          context.read<ContentProvider>().currentIndex];
                    }
                    int? childId;
                    if (current != null) {
                      childId = current.id;
                    }

                    print(childId);
                    await context
                        .read<ContentProvider>()
                        .createFolder(name: result, childId: childId);
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
