import 'package:flutter/foundation.dart';
import 'package:parallel/_data/data_source/api/abstract/api_data_source.dart';
import 'package:parallel/_data/data_source/api/abstract/sources/local_storage_data_source.dart';
import 'package:parallel/_data/model/list_model.dart';
import 'package:parallel/_data/model/model/auth/remaining_attempts_model.dart';
import 'package:parallel/_data/model/model/connection_model.dart';
import 'package:parallel/_data/model/model/file_model.dart';
import 'package:parallel/_data/model/model/gallery_model.dart';
import 'package:parallel/_data/model/model/post/my_post_model.dart';
import 'package:parallel/_data/model/model/profile/profile_model.dart';
import 'package:parallel/_data/model/model/question_model.dart';
import 'package:parallel/_data/model/model/relations_count_model.dart';
import 'package:parallel/_data/model/request/update_profile/update_custom_info_request.dart';
import 'package:parallel/_domain/error_handler/error_handler.dart';
import 'package:parallel/_domain/error_handler/exception/base_exeption.dart';
import 'package:parallel/_domain/repository/abstract/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiDataSource _apiDataSource;
  final LocalStorageDataSource _localDataSource;
  final ErrorHandler _errorHandler;

  ProfileRepositoryImpl(
    this._apiDataSource,
    this._localDataSource,
    this._errorHandler,
  );

  @override
  Future<ProfileModel> getProfileById({
    required String profileId,
  }) {
    return _apiDataSource.profileDataSource.getProfileById(profileId: profileId).catchError(
      (exception, trace) {
        _errorHandler.handleException(exception);
        throw exception is BaseException ? exception : exception as Exception;
      },
    );
  }

  @override
  Future<ProfileModel> getUserMe() async {
    try {
      final ProfileModel user = await _apiDataSource.profileDataSource.getSelfProfile();
      await _localDataSource.saveUser(user);
      return user;
    } catch (error) {
      _errorHandler.handleException(error);
      throw error is BaseException ? error : error as Exception;
    }
  }

  @override
  ValueListenable userMe() {
    return _localDataSource.userListenable();
  }

  @override
  Future<ProfileModel> editProfile({
    required String id,
    required String name,
    String? birthdayDate,
    String? country,
    String? aboutMe,
    required List<String> tags,
    String? avatarUri,
    required List<UpdateCustomInfoRequest> customFields,
  }) async {
    final ProfileModel user = await _apiDataSource.profileDataSource.editProfile(
      id: id,
      name: name,
      birthdayDate: birthdayDate,
      country: country,
      aboutMe: aboutMe,
      tags: tags,
      avatarUri: avatarUri,
      customFields: customFields,
    );
    await _localDataSource.saveUser(user);
    return user;
  }

  @override
  Future<RelationsCountModel> getRelationsCount({
    required String profileId,
  }) {
    return _apiDataSource.profileDataSource.getRelationsCount(
      profileId: profileId,
    );
  }

  @override
  Future<FileModel> sendFile({
    String? filePath,
  }) {
    return _apiDataSource.profileDataSource
        .sendFile(
      filePath: filePath,
    )
        .catchError(
      (exception) {
        _errorHandler.handleException(exception);
        throw exception is BaseException ? exception : exception as Exception;
      },
    );
  }

  @override
  Future<List<QuestionModel>> getQuestionsList() {
    return _apiDataSource.profileDataSource.getQuestionsList();
  }

  @override
  Future<void> submitAnswers({required List<Map<String, dynamic>> answersList}) {
    return _apiDataSource.profileDataSource.submitAnswers(answersList: answersList).catchError(
      (exception) {
        _errorHandler.handleException(exception);
        throw exception is BaseException ? exception : exception as Exception;
      },
    );
  }

  @override
  Future<RemainingAttemptsModel> changeEmailWithCode({
    required String email,
    required String code,
  }) {
    return _apiDataSource.profileDataSource.changeEmailWithCode(
      email: email,
      code: code,
    );
  }

  @override
  Future<RemainingAttemptsModel> sendEmailChangeCode() {
    return _apiDataSource.profileDataSource.sendEmailChangeCode();
  }

  @override
  Future<void> deleteProfile() async {
    await _apiDataSource.profileDataSource.deleteProfile();
    await _localDataSource.clearLocalDataBase();
    await _apiDataSource.authDataSource.saveAuthToken('');
    await _apiDataSource.authDataSource.saveRefreshToken('');
  }

  @override
  Future<void> createPost({
    required String text,
    String? mediaUrl,
    required int type,
    required String nftLink,
  }) {
    return _apiDataSource.profileDataSource
        .createPost(
      text: text,
      mediaUrl: mediaUrl,
      type: type,
      nftLink: nftLink,
    )
        .catchError(
      (exception) {
        _errorHandler.handleException(exception);
        throw exception is BaseException ? exception : exception as Exception;
      },
    );
  }

  @override
  Future<List<MyPostModel>> getMyPost() {
    return _apiDataSource.profileDataSource.getMyPost().catchError(
      (exception) {
        _errorHandler.handleException(exception);
        throw exception is BaseException ? exception : exception as Exception;
      },
    );
  }

  @override
  Future<void> follow({required String followingId}) {
    return _apiDataSource.profileDataSource
        .follow(
      followingId: followingId,
    )
        .catchError(
      (exception) {
        _errorHandler.handleException(exception);
        throw exception is BaseException ? exception : exception as Exception;
      },
    );
  }

  @override
  Future<void> unfollow({
    required String unfollowId,
  }) {
    return _apiDataSource.profileDataSource
        .unfollow(
      unfollowId: unfollowId,
    )
        .catchError(
      (exception) {
        _errorHandler.handleException(exception);
        throw exception is BaseException ? exception : exception as Exception;
      },
    );
  }

  @override
  Future<ListModel<GalleryModel>> getGalleryList({
    required String userId,
    required int page,
  }) {
    return _apiDataSource.profileDataSource.getGalleryList(
      userId: userId,
      page: page,
    );
  }

  @override
  Future<List<ConnectionModel>> getFollowersList() {
    return _apiDataSource.profileDataSource.getFollowersList();
  }

  @override
  Future<List<ConnectionModel>> getFollowsList() {
    return _apiDataSource.profileDataSource.getFollowsList();
  }

  @override
  Future<void> blockUser({required String userId}) {
    return _apiDataSource.profileDataSource.blockUser(
      userId: userId,
    );
  }

  @override
  Future<void> unBlockUser({required String userId}) {
    return _apiDataSource.profileDataSource.unBlockUser(
      userId: userId,
    );
  }

  @override
  Future<void> sendReportUser({
    required String userId,
    required String topic,
    required String description,
  }) {
    return _apiDataSource.profileDataSource.sendReportUser(
      userId: userId,
      topic: topic,
      description: description,
    );
  }
}
