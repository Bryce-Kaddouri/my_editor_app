import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:my_editor_app/core/data/usecase/usecase.dart';
import 'package:my_editor_app/src/features/home/business/usecase/create_content_usecase.dart';
import 'package:my_editor_app/src/features/home/business/usecase/delete_content_usecase.dart';
import 'package:my_editor_app/src/features/home/business/usecase/get_content_by_id_usecase.dart';
import 'package:my_editor_app/src/features/home/business/usecase/list_all_content_usecase.dart';
import 'package:my_editor_app/src/features/home/business/usecase/update_content_usecase.dart';
import 'package:my_editor_app/src/features/home/data/model/content_model.dart';

class ContentProvider with ChangeNotifier {
  final CreateContentUseCase _createContentUseCase = CreateContentUseCase();
  final GetContentByIdUseCase _getContentByIdUseCase = GetContentByIdUseCase();
  final UpdateContentUseCase _updateContentUseCase = UpdateContentUseCase();
  final DeleteContentUseCase _deleteContentUseCase = DeleteContentUseCase();
  final ListAllContentUseCase _listAllContentUseCase = ListAllContentUseCase();

  ContentProvider() {
    print("ContentProvider");
    listAllContent();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  List<ContentModel> _contentList = [];
  List<ContentModel> get contentList => _contentList;
  void setContentList(List<ContentModel> contentList) {
    _contentList = contentList;
    notifyListeners();
  }

  ContentModel? _selectedContent;
  ContentModel? get selectedContent => _selectedContent;
  void setSelectedContent(ContentModel? content) {
    _selectedContent = content;
    notifyListeners();
  }

  int _currentIndex = -1;
  int get currentIndex => _currentIndex;
  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> createFolder(
      {required String name, required int? childId}) async {
    ContentModel content = ContentModel(
      id: -1,
      name: name,
      isFolder: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      userId: "",
      childId: childId,
      content: null,
    );
    setIsLoading(true);
    final result = await _createContentUseCase.call(content);
    result.fold(
      (failure) {
        // Handle failure
        print(failure.errorMessage);
      },
      (content) {
        _contentList.add(content);
        notifyListeners();
      },
    );
    setIsLoading(false);
  }

  Future<int?> createPage(
      {required String name,
      required int? childId,
      required Map<String, dynamic>? content}) async {
    ContentModel contentModel = ContentModel(
      id: -1,
      name: name,
      isFolder: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      userId: "",
      childId: childId,
      content: content,
    );
    setIsLoading(true);
    final result = await _createContentUseCase.call(contentModel);
    int? id;
    result.fold(
      (failure) {
        // Handle failure
        print(failure.errorMessage);
      },
      (content) {
        print(content.toJson());
        _contentList.add(content);
        notifyListeners();
        id = content.id;
      },
    );
    setIsLoading(false);
    return id;
  }

  Future<void> getContentById(int id) async {
    setIsLoading(true);
    final result = await _getContentByIdUseCase.call(id);
    result.fold(
      (failure) {
        // Handle failure
      },
      (content) {
        setSelectedContent(content);
      },
    );
    setIsLoading(false);
  }

  Future<void> updateContent(ContentModel content) async {
    setIsLoading(true);
    final result = await _updateContentUseCase.call(content);
    result.fold(
      (failure) {
        // Handle failure
        print(failure.errorMessage);
      },
      (updatedContent) {
        final index = _contentList.indexWhere((c) => c.id == updatedContent.id);
        if (index != -1) {
          print("update");
          _contentList[index] = updatedContent;
          notifyListeners();
        }
      },
    );
    setIsLoading(false);
  }

  Future<void> deleteContent(int id) async {
    setIsLoading(true);
    final result = await _deleteContentUseCase.call(id);
    result.fold(
      (failure) {
        // Handle failure
      },
      (success) {
        _contentList.removeWhere((content) => content.id == id);
        notifyListeners();
      },
    );
    setIsLoading(false);
  }

  Future<void> listAllContent() async {
    setIsLoading(true);
    final result = await _listAllContentUseCase.call(NoParams());
    result.fold(
      (failure) {
        print(failure.errorMessage);
        // Handle failure
      },
      (contentList) {
        setContentList(contentList);
      },
    );
    setIsLoading(false);
  }
}
