import 'package:parallel/_data/data_source/api/abstract/api_data_source.dart';
import 'package:parallel/_domain/error_handler/error_handler.dart';
import 'package:parallel/_domain/repository/abstract/auth_repository.dart';
import 'package:parallel/_domain/repository/abstract/profile_repository.dart';
import 'package:parallel/_domain/repository/abstract/search_repository.dart';

abstract class Repository {
  final ApiDataSource _apiDataSource;
  final ErrorHandler _errorHandler;

  late final AuthRepository authRepository;
  late final ProfileRepository profileRepository;
  late final SearchRepository searchRepository;

  Repository({
    required ApiDataSource apiDataSource,
    required ErrorHandler errorHandler,
  })  : _apiDataSource = apiDataSource,
        _errorHandler = errorHandler;

  String get host => _apiDataSource.host;
}
