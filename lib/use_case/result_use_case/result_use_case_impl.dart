import 'package:video_audio_booth/domain/repository/result_repository/result_repository_impl.dart';
import 'package:video_audio_booth/use_case/entity/result.dart';

import 'result_use_case.dart';

class ResultUseCaseImpl implements ResultUseCase {
  factory ResultUseCaseImpl() => instance;

  ResultUseCaseImpl._();

  static final ResultUseCaseImpl instance = ResultUseCaseImpl._();
  final _resultRepositoryImpl = ResultRepositoryImpl.instance;

  @override
  Future<Result<String>> getBackVideoPath() async {
    return _resultRepositoryImpl.getBackVideoPath();
  }

  @override
  Future<Result<String>> getFrontVideoPath() {
    return _resultRepositoryImpl.getFrontVideoPath();
  }
}
