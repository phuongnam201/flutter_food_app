class SignUpBody {
  String name;
  String email;
  String password;
  String phone;
  SignUpBody({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["f_name"] = this.name;
    data["email"] = this.email;
    data["phone"] = this.phone;
    data["password"] = this.password;

    return data;
  }
}
