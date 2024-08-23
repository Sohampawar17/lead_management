class UserDetails {
  String? username;
  String? fullName;
  String? email;
  String? name;
  String? mobileNo;
  String? company;
  String? userImage;
  String? supportMobile;
  String? supportSms;

  UserDetails(
      {this.username,
      this.fullName,
      this.email,
      this.name,
      this.mobileNo,
      this.company,
      this.userImage,
      this.supportMobile,
      this.supportSms});

  UserDetails.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullName = json['full_name'];
    email = json['email'];
    name = json['name'];
    mobileNo = json['mobile_no'];
    company = json['company'];
    userImage = json['user_image'];
    supportMobile = json['support_mobile'];
    supportSms = json['support_sms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['full_name'] = fullName;
    data['email'] = email;
    data['name'] = name;
    data['mobile_no'] = mobileNo;
    data['company'] = company;
    data['user_image'] = userImage;
    data['support_mobile'] = supportMobile;
    data['support_sms'] = supportSms;
    return data;
  }
}
