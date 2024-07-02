import 'package:dartz/dartz.dart';
import 'package:my_editor_app/core/data/exception/failure.dart';
import 'package:my_editor_app/src/features/home/business/repository/content_repository.dart';
import 'package:my_editor_app/src/features/home/data/datasource/content_datasource.dart';
import 'package:my_editor_app/src/features/home/data/model/content_model.dart';

class ContentRepositoryImpl implements ContentRepository {
  final ContentDataSource _contentDataSource = ContentDataSource();

  @override
  Future<Either<Failure, ContentModel>> createContent(ContentModel content) async {
    return await _contentDataSource.createContent(content);
  }

  @override
  Future<Either<Failure, ContentModel>> getContentById(int id) async {
    return await _contentDataSource.getContentById(id);
  }

  @override
  Future<Either<Failure, ContentModel>> updateContent(ContentModel content) async {
    return await _contentDataSource.updateContent(content);
  }

  @override
  Future<Either<Failure, bool>> deleteContent(int id) async {
    return await _contentDataSource.deleteContent(id);
  }

  @override
  Future<Either<Failure, List<ContentModel>>> listAllContent() async {
    return await _contentDataSource.listAllContent();
  }
}

