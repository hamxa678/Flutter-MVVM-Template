import 'package:dio/dio.dart' as dio;

class UserProfile {
  String? name; // done
  String? email; // done
  String? fcmToken; // done
  String? phone; // done
  String? imageUrl; // done
  String? gender; // done
  String? location; // done
  String? dob;

  UserProfile({
    this.name,
    this.email,
    this.fcmToken,
    this.phone,
    this.imageUrl,
    this.gender,
    this.location,
    this.dob,
  });

  factory UserProfile.fromMap(map) {
    return UserProfile(
      name : map['name'],
      email : map['email'],
      fcmToken : map['fcm_token'],
      phone : map['phone'],
      imageUrl : map['image_url'],
      gender : map['gender'],
      location : map['location'],
      dob : map['dob'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name' : name,
    'email' : email,
  'phone' : phone,
    'gender' : gender,
    'location' : location
    };
  }

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
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
