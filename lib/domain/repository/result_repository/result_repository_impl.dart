import 'package:video_audio_booth/use_case/entity/result.dart';
import 'package:video_audio_booth/utils/core/constants.dart';

import 'result_repository.dart';

class ResultRepositoryImpl implements ResultRepository{
  factory ResultRepositoryImpl() => instance;

  ResultRepositoryImpl._();

  static final ResultRepositoryImpl instance = ResultRepositoryImpl._();

  @override
  Future<Result<String>> getBackVideoPath()async {
    try{
      final result=await channel.invokeMethod("getBackVideoPath");
      print("result $result");
      return Result.success(result);
    }catch(e){
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<String>> getFrontVideoPath()async {
    try{
      final result=await channel.invokeMethod("getFrontVideoPath");
      print("result $result");
      return Result.success(result);
    }catch(e){
      return Result.failure(e.toString());
    }
  }
}