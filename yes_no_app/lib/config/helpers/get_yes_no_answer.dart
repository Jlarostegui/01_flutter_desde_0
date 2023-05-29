import 'package:dio/dio.dart';
import 'package:yes_no_app/domain/entities/mesaage.dart';
import 'package:yes_no_app/infrastructure/models/yes_no_model.dart';

class GetYesNoAnswer {
  final _dio = Dio(
    BaseOptions(),
  );

  Future<Message> getAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');
    final YesNoModel yesNoModel = YesNoModel.fromJson(response.data);

    return yesNoModel.toMessageEntity();
    // return Message(
    //     text: yesNoModel.answer,
    //     fromWho: FromWho.hers,
    //     imageUrl: yesNoModel.image);
  }
}
