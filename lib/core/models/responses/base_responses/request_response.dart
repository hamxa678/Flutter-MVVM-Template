class RequestResponse {
  late bool success;
  String? error;
  late Map<String, dynamic> data;

  RequestResponse(this.success, {this.error});

  RequestResponse.fromJson(json) {
    data = json;
    success = json['success'];
    error = json['error'];
  }

  toJson() {
    return {
      'success': success,
      'error': error,
      'body': data,
    };
  }
}
