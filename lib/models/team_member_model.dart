class Team_member {
  String? name;
  String? owner;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? role;
  String? designation;
  String? company;
  String? password;
  String? confirmPassword;


  Team_member(
      {this.name,
      this.owner,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.role,
      this.designation,
      this.company,
      this.password,
      this.confirmPassword,
   });

  Team_member.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    role = json['role'];
    designation = json['designation'];
    company = json['company'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['role'] = role;
    data['designation'] = designation;
    data['company'] = company;
    data['password'] = password;
    data['confirm_password'] = confirmPassword;
  
    return data;
  }
}
