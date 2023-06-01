class UpdatePasswordBody {
  String? oldPassword;
  String? newPassword;

  UpdatePasswordBody({this.oldPassword, this.newPassword});

  toJson() => {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      };
}
