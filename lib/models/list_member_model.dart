class MemberList {
  String? firstName;
  String? lastName;
  String? company;
  String? name;

  MemberList(
      {this.firstName,
      this.lastName,
      this.company,
      this.name});

  MemberList.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['company'] = company;
    data['name'] = name;
    return data;
  }
}
