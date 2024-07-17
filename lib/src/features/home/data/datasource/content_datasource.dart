import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/data/exception/failure.dart';
import '../model/content_model.dart';

class ContentDataSource {
  final _client = Supabase.instance.client;

  // Method to create content
  Future<Either<Failure, ContentModel>> createContent(
      ContentModel content) async {
    try {
      Map<String, dynamic> data = content.toJson(isForAdd: true);
      data['user_id'] = _client.auth.currentUser!.id;
      final response = await _client
          .from('content')
          .insert(
            data,
          )
          .select()
          .single();
      return Right(ContentModel.fromJson(response));
    } on PostgrestException catch (e) {
      return Left(ServerFailure(errorMessage: e.message, errorCode: e.code));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString(), errorCode: null));
    }
  }

  // Method to read content by ID
  Future<Either<Failure, ContentModel>> getContentById(int id) async {
    try {
      final response =
          await _client.from('content').select().eq('id', id).single();
      return Right(ContentModel.fromJson(response));
    } on PostgrestException catch (e) {
      return Left(ServerFailure(errorMessage: e.message, errorCode: e.code));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString(), errorCode: null));
    }
  }

  // Method to update content
  Future<Either<Failure, ContentModel>> updateContent(
      ContentModel content) async {
    try {
      final response = await _client
          .from('content')
          .update(content.toJson())
          .eq('id', content.id!)
          .select()
          .single();
      return Right(ContentModel.fromJson(response));
    } on PostgrestException catch (e) {
      return Left(ServerFailure(errorMessage: e.message, errorCode: e.code));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString(), errorCode: null));
    }
  }

  // Method to delete content
  Future<Either<Failure, bool>> deleteContent(int id) async {
    try {
      await _client.from('content').delete().eq('id', id);
      return Right(true);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(errorMessage: e.message, errorCode: e.code));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString(), errorCode: null));
    }
  }

  // Method to list all content
  Future<Either<Failure, List<ContentModel>>> listAllContent(
      int level, int? parentId) async {
    try {
      print(_client.auth.currentUser!.id);
      var response = await _client
          .rpc<List<Map<String, dynamic>>>('get_nested_folders', params: {
        'p_user_id': _client.auth.currentUser!.id,
        'max_level': level
      });
      if (parentId != null) {
        response = response
            .where((element) => element['parent_id'] == parentId)
            .toList();
      }
      print('-----------------');
      print(response.toString());
      print('-----------------');
      List<ContentModel> allContentList = [];
      for (var element in response) {
        allContentList.add(ContentModel(
          id: element['id'],
          name: element['name'],
          parentId: element['parent_id'],
          userId: _client.auth.currentUser!.id,
          content: element['content'],
          createdAt: DateTime.parse(element['created_at']),
          updatedAt: DateTime.parse(element['updated_at']),
          isFolder: element['is_folder'],
          level: element['level'],
        ));
      }

      return Right(allContentList);
    } on PostgrestException catch (e) {
      print('error : $e');
      return Left(ServerFailure(errorMessage: e.message, errorCode: e.code));
    } catch (e) {
      print('error : $e');
      return Left(ServerFailure(errorMessage: e.toString(), errorCode: null));
    }
  }
}
