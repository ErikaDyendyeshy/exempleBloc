import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parallel/_data/data_source/api/abstract/sources/profile_data_source.dart';
import 'package:parallel/_data/data_source/api/impl/api_data_source_impl.dart';
import 'package:parallel/_data/model/list_model.dart';
import 'package:parallel/_data/model/list_model/gallery_list_response.dart';
import 'package:parallel/_data/model/model/answer_model.dart';
import 'package:parallel/_data/model/model/auth/remaining_attempts_model.dart';
import 'package:parallel/_data/model/model/block_user_model.dart';
import 'package:parallel/_data/model/model/connection_model.dart';
import 'package:parallel/_data/model/model/file_model.dart';
import 'package:parallel/_data/model/model/following_model.dart';
import 'package:parallel/_data/model/model/gallery_model.dart';
import 'package:parallel/_data/model/model/post/my_post_model.dart';
import 'package:parallel/_data/model/model/profile/profile_model.dart';
import 'package:parallel/_data/model/model/question_model.dart';
import 'package:parallel/_data/model/model/relations_count_model.dart';
import 'package:parallel/_data/model/model/unfollow_model.dart';
import 'package:parallel/_data/model/report_model.dart';
import 'package:parallel/_data/model/request/empty_request.dart';
import 'package:parallel/_data/model/request/new_email_request.dart';
import 'package:parallel/_data/model/request/post_request.dart';
import 'package:parallel/_data/model/request/update_profile/update_custom_info_request.dart';
import 'package:parallel/_data/model/request/update_profile/update_profile_request.dart';
import 'package:parallel/_data/model/request/update_profile/update_tag_request.dart';
import 'package:parallel/_data/model/request/update_profile/update_user_request.dart';
import 'package:parallel/const.dart';
import 'package:parallel/util/http_extension.dart';

class ProfileDataSourceImpl extends ProfileDataSource {
  ProfileDataSourceImpl({
    required super.getConnect,
    required super.apiDataSource,
  });

  @override
  Future<ProfileModel> getProfileById({
    required String profileId,
  }) {
    return getConnect
        .getRequest(
      url: 'profile/get/$profileId',
    )
        .then((Response response) {
      return ProfileModel.fromJson(
        jsonDecode(
          response.bodyString!,
        ),
      );
    });
  }

  @override
  Future<ProfileModel> getSelfProfile() {
    return getConnect
        .getRequest(
      url: 'profile/me',
    )
        .then((Response response) {
      return ProfileModel.fromJson(
        jsonDecode(
          response.bodyString!,
        ),
      );
    });
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
  }) {
    UpdateUserRequest user = UpdateUserRequest(
      id: id,
      name: name,
      birthDate: birthdayDate,
      country: country,
      aboutMe: aboutMe,
      avatarUri: avatarUri,
    );
    List<UpdateTagRequest> tag = tags.map((tag) => UpdateTagRequest(tag: tag)).toList();
    final tagList = tag;
    List<UpdateCustomInfoRequest> customInfo = customFields.map((field) {
      return UpdateCustomInfoRequest(
        title: field.title,
        info: field.info,
      );
    }).toList();
    return getConnect
        .postRequest(
          url: 'profile/update',
          request: UpdateProfileRequest(
            updateUserRequest: user,
            updateTagRequest: tagList,
            updateCustomInfoRequest: customInfo,
          ),
        )
        .then(
          (Response response) => ProfileModel.fromJson(
            jsonDecode(
              response.bodyString!,
            ),
          ),
        );
  }

  @override
  Future<RelationsCountModel> getRelationsCount({
    required String profileId,
  }) {
    return getConnect
        .getRequest(
          url: 'social/relations_count/$profileId',
        )
        .then(
          (Response response) => RelationsCountModel.fromJson(
            jsonDecode(
              response.bodyString!,
            ),
          ),
        );
  }

  @override
  Future<FileModel> sendFile({String? filePath}) async {
    const String tokenKey = 'Authorization';

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${apiUrl}api/file_storage/upload'),
    );

    ApiDataSourceImpl apiDataSourceImpl = Get.find();
    String? token = await apiDataSourceImpl.authDataSource.getAuthToken();
    request.headers.addAll({tokenKey: 'Bearer $token'});

    var multipartFile = await http.MultipartFile.fromPath(
      'file',
      filePath!,
    );

    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();

    return FileModel.fromJson(jsonDecode(respStr));
  }

  @override
  Future<List<QuestionModel>> getQuestionsList() {
    return getConnect
        .getRequest(url: 'personality/personalized_questions')
        .then((Response response) {
      final List<dynamic> jsonResponse = response.body;
      final List<QuestionModel> questions =
          jsonResponse.map((questionJson) => QuestionModel.fromJson(questionJson)).toList();
      return questions;
    });
  }

  @override
  Future<void> submitAnswers({required List<Map<String, dynamic>> answersList}) async {
    final List<AnswerModel> formattedAnswers = [];

    for (final answer in answersList) {
      final questionId = answer['question_id'];
      final selectedAnswer = answer['answer'];

      if (questionId != null && selectedAnswer != null) {
        final formattedAnswer = AnswerModel(
          answer: selectedAnswer,
          questionId: questionId,
        );
        formattedAnswers.add(formattedAnswer);
      }
    }
    getConnect.postRequest(
      url: 'personality/answer_questions',
      request: formattedAnswers,
    );
  }

  @override
  Future<RemainingAttemptsModel> changeEmailWithCode({
    required String email,
    required String code,
  }) {
    return getConnect
        .postRequest(
          url: 'auth/change-email-with-code',
          request: NewEmailRequest(
            newEmail: email,
            code: code,
          ),
        )
        .then(
          (Response response) => RemainingAttemptsModel.fromJson(
            jsonDecode(
              response.bodyString!,
            ),
          ),
        );
  }

  @override
  Future<RemainingAttemptsModel> sendEmailChangeCode() {
    return getConnect
        .postRequest(
          url: 'auth/send-email-change-code',
          request: EmptyRequest(),
        )
        .then(
          (Response response) => RemainingAttemptsModel.fromJson(
            jsonDecode(
              response.bodyString!,
            ),
          ),
        );
  }

  @override
  Future<void> deleteProfile() {
    return getConnect.deleteRequest(
      url: 'auth/delete_account',
      request: EmptyRequest(),
    );
  }

  @override
  Future<void> createPost({
    required String text,
    String? mediaUrl,
    required int type,
    required String nftLink,
  }) {
    return getConnect
        .postRequest(
            url: 'post/create/',
            request: PostRequest(
              text: text,
              mediaUrl: mediaUrl,
              type: type,
              nftLink: nftLink,
            ))
        .then(
          (Response response) => response.isOk,
        );
  }

  @override
  Future<List<MyPostModel>> getMyPost() {
    return getConnect
        .getRequest(
      url: 'post/my_posts',
    )
        .then((Response response) {
      final List<dynamic> jsonResponse = response.body;
      final List<MyPostModel> posts =
          jsonResponse.map((postJson) => MyPostModel.fromJson(postJson)).toList();
      return posts;
    });
  }

  @override
  Future<void> follow({required String followingId}) {
    return getConnect
        .postRequest(
          url: 'social/follow',
          request: FollowingModel(
            followingId: followingId,
          ),
        )
        .then(
          (value) => value.isOk,
        );
  }

  @override
  Future<void> unfollow({
    required String unfollowId,
  }) {
    return getConnect
        .postRequest(
          url: 'social/unfollow',
          request: UnfollowModel(
            unfollowId: unfollowId,
          ),
        )
        .then(
          (value) => value.isOk,
        );
  }

  @override
  Future<ListModel<GalleryModel>> getGalleryList({
    required String userId,
    required int page,
  }) {
    final Map<String, dynamic> query = {};
    query['user_id'] = userId;
    query['page'] = page.toString();
    return getConnect.getRequest(url: 'gallery/list', query: query).then((Response response) {
      return GalleryListResponse.fromJson(
        jsonDecode(response.bodyString!),
      );
    });
  }

  Future<List<ConnectionModel>> getConnectionList() {
    return getConnect.getRequest(url: 'social/my_follows').then((Response response) {
      List<dynamic> responseBody = jsonDecode(response.bodyString!);
      return responseBody.map((json) => ConnectionModel.fromJson(json)).toList();
    });
  }

  @override
  Future<List<ConnectionModel>> getFollowersList() {
    return getConnect.getRequest(url: 'social/my_followers').then((Response response) {
      List<dynamic> responseBody = jsonDecode(response.bodyString!);
      return responseBody.map((json) => ConnectionModel.fromJson(json)).toList();
    });
  }

  @override
  Future<List<ConnectionModel>> getFollowsList() {
    return getConnect.getRequest(url: 'social/my_follows').then((Response response) {
      List<dynamic> responseBody = jsonDecode(response.bodyString!);
      return responseBody.map((json) => ConnectionModel.fromJson(json)).toList();
    });
  }

  @override
  Future<void> blockUser({required String userId}) {
    return getConnect
        .postRequest(
            url: 'social/ignore',
            request: BlockUserModel(
              userId: userId,
            ))
        .then((Response response) {
      response.isOk;
    });
  }

  @override
  Future<void> unBlockUser({required String userId}) {
    return getConnect
        .postRequest(
            url: 'social/remove_ignore',
            request: BlockUserModel(
              userId: userId,
            ))
        .then((Response response) {
      response.isOk;
    });
  }

  //TODO there is no endpoint.
  @override
  Future<void> sendReportUser({
    required String userId,
    required String topic,
    required String description,
  }) {
    return getConnect
        .postRequest(
            url: 'url',
            request: ReportModel(
              id: userId,
              topic: topic,
              description: description,
            ))
        .then((value) => value.isOk);
  }
}
