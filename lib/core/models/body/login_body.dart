class LoginBody {
  String? email;
  String? password;

  LoginBody({this.email, this.password});

  toJson() => {
        'email': email,
        'password': password,
      };
}
