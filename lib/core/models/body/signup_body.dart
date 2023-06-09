import 'dart:io';
import 'package:dio/dio.dart' as dio;

class SignUpBody {
  String? email;
  String? password;
  String? name;
  String? location;
  String? gender;
  String? phone;
  File? image;
  String? dob;

  SignUpBody({
    this.email,
    this.password,
    this.gender,
    this.location,
    this.name,
    this.phone,
    this.image,
    this.dob,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'location': location,
      'gender': gender,
      'phone': phone,
      // 'image':
      //     image != null ? await dio.MultipartFile.fromFile(image!.path) : null,
      'dob': dob,
    };
  }
}
