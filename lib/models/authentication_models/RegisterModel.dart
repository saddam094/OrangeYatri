class RegisterModel {
  String? name;
  String? organisation;
  String? gst;
  String? email;
  String? phone;
  String? password;

  RegisterModel(
      {this.name,
        this.organisation,
        this.gst,
        this.email,
        this.phone,
        this.password});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    organisation = json['organisation'];
    gst = json['gst'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['organisation'] = this.organisation;
    data['gst'] = this.gst;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    return data;
  }
}
