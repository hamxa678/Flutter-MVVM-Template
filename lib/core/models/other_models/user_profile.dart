import 'package:dio/dio.dart' as dio;

class UserProfile {
  String? name;
  String? email;
  String? fcmToken;
  String? emailVerifiedAt;
  String? phone;
  String? imageUrl;
  String? gender;
  String? location;
  String? mobile;
  String? dob;

  UserProfile({
    this.name,
    this.email,
    this.fcmToken,
    this.emailVerifiedAt,
    this.phone,
    this.imageUrl,
    this.gender,
    this.location,
    this.mobile,
    this.dob,
  });

  UserProfile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    fcmToken = json['fcm_token'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    imageUrl = json['image_url'];
    gender = json['gender'];
    location = json['location'];
    dob = json['dob'];
  }

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    // data['fcmToken'] = this.fcmToken;
    data['phone'] = phone;
    data['image'] =
        imageUrl != null ? await dio.MultipartFile.fromFile(imageUrl!) : null;
    data['gender'] = gender;
    data['location'] = location;
    return data;
  }

  deepCopy() {
    return UserProfile(
        name: name,
        email: email,
        fcmToken: fcmToken,
        phone: phone,
        imageUrl: imageUrl,
        gender: gender,
        location: location);
  }
}
