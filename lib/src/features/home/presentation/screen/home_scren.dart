import 'package:flutter/material.dart' show Scaffold, AppBar, BottomNavigationBar, FloatingActionButton;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:my_editor_app/src/features/authentication/presentation/provider/auth_provider.dart';
import 'package:my_editor_app/src/features/home/presentation/provider/content_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
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

  final _items = <BreadcrumbItem<int>>[
  BreadcrumbItem(label: Text('Home'), value: 0),
  BreadcrumbItem(label: Text('Documents'), value: 1),
  BreadcrumbItem(label: Text('Design'), value: 2),
  BreadcrumbItem(label: Text('Northwind'), value: 3),
  BreadcrumbItem(label: Text('Images'), value: 4),
  BreadcrumbItem(label: Text('Folder1'), value: 5),
  BreadcrumbItem(label: Text('Folder2'), value: 6),
  BreadcrumbItem(label: Text('Folder3'), value: 7),
  BreadcrumbItem(label: Text('Folder4'), value: 8),
  BreadcrumbItem(label: Text('Folder5'), value: 9),
  BreadcrumbItem(label: Text('Folder6'), value: 10),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(children: [
        BreadcrumbBar<int>(
  items: _items,
  onItemPressed: (item) {
    setState(() {
      final index = _items.indexOf(item);
      _items.removeRange(index + 1, _items.length);
    });
  },
),
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
  onItemInvoked: (item, reason) async => debugPrint('onItemInvoked: $item'),
  onSelectionChanged: (selectedItems) async => debugPrint(
    'onSelectionChanged: ${selectedItems.map((i) => i.value)}',
  ),
  onSecondaryTap: (item, details) async {
    debugPrint('onSecondaryTap $item at ${details.globalPosition}');
  },
)
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
                                    Navigator.pop(context, _pageNameController.text);
                                    // Add page creation logic here
                                  }
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
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
                                    Navigator.pop(context, _folderNameController.text);
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
                     await context.read<ContentProvider>().createFolder(name: result, childId: null);

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
          BottomNavigationBarItem(icon: Icon(FluentIcons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}