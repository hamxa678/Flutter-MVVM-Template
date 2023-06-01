
import 'base_responses/base_response.dart';

class ResetPasswordResponse extends BaseResponse {
  String? message;

  /// Default constructor
  ResetPasswordResponse(success, {error, this.message})
      : super(success, error: error);

  /// Named Constructor
  ResetPasswordResponse.fromJson(json) : super.fromJson(json) {
    if (json['body'] != null) message = json['body']['message'];
  }
}
