import 'package:parallel/_data/data_source/api/abstract/data_source.dart';
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

abstract class ProfileDataSource extends DataSource {
  ProfileDataSource({
    required super.getConnect,
    required super.apiDataSource,
  });

  Future<ProfileModel> getProfileById({
    required String profileId,
  });

  Future<ProfileModel> getSelfProfile();

  Future<ProfileModel> editProfile({
    required String id,
    required String name,
    String? birthdayDate,
    String? country,
    String? aboutMe,
    required List<String> tags,
    String? avatarUri,
    required List<UpdateCustomInfoRequest> customFields,
  });

  Future<RelationsCountModel> getRelationsCount({
    required String profileId,
  });

  Future<FileModel> sendFile({
    String? filePath,
  });

  Future<List<QuestionModel>> getQuestionsList();

  Future<void> submitAnswers({
    required List<Map<String, dynamic>> answersList,
  });

  Future<RemainingAttemptsModel> changeEmailWithCode({
    required String email,
    required String code,
  });

  Future<RemainingAttemptsModel> sendEmailChangeCode();

  Future<void> deleteProfile();

  Future<void> createPost({
    required String text,
    String? mediaUrl,
    required int type,
    required String nftLink,
  });

  Future<List<MyPostModel>> getMyPost();

  Future<ListModel<GalleryModel>> getGalleryList({
    required String userId,
    required int page,
  });

  Future<void> follow({
    required String followingId,
  });

  Future<void> unfollow({
    required String unfollowId,
  });

  Future<List<ConnectionModel>> getFollowersList();

  Future<List<ConnectionModel>> getFollowsList();

  Future<void> blockUser({required String userId});

  Future<void> unBlockUser({required String userId});

  Future<void> sendReportUser({
    required String userId,
    required String topic,
    required String description,
  });
}
