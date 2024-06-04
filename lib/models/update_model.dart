class UpdateModel {
  String? name;
  String? email;
  String? phone;
  String? password;

  UpdateModel({
    required this.name,
    required this.email,
    required this.phone,
    this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["f_name"] = this.name;
    data["email"] = this.email;
    data["phone"] = this.phone;

    if (this.password != null && this.password!.isNotEmpty) {
      data["password"] = this.password;
    }

    return data;
  }
}
