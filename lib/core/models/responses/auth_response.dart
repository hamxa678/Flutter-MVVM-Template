
import 'base_responses/base_response.dart';

  String? accessToken;

  /// Default constructor
  AuthResponse(success, {error, this.accessToken})
      : super(success, error: error);

  /// Named Constructor
  AuthResponse.fromJson(json) : super.fromJson(json) {
    if (json['body'] != null) accessToken = json['body']['token'];
  }
}
