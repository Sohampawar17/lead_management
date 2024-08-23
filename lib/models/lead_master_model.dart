class LeadMasters {
  List<Notes>? notes;
  List<String>? activityLead;
  List<Users>? users;
  List<WhatsappSms>? whatsappSms;
  String? assignTo;

  LeadMasters(
      {this.notes,
      this.activityLead,
      this.users,
      this.whatsappSms,
      this.assignTo});

  LeadMasters.fromJson(Map<String, dynamic> json) {
    if (json['notes'] != null) {
      notes = <Notes>[];
      json['notes'].forEach((v) {
        notes!.add(Notes.fromJson(v));
      });
    }
    activityLead = json['activity_lead'].cast<String>();
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
    if (json['whatsapp_sms'] != null) {
      whatsappSms = <WhatsappSms>[];
      json['whatsapp_sms'].forEach((v) {
        whatsappSms!.add(WhatsappSms.fromJson(v));
      });
    }
    assignTo = json['assign_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (notes != null) {
      data['notes'] = notes!.map((v) => v.toJson()).toList();
    }
    data['activity_lead'] = activityLead;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    if (whatsappSms != null) {
      data['whatsapp_sms'] = whatsappSms!.map((v) => v.toJson()).toList();
    }
    data['assign_to'] = assignTo;
    return data;
  }
}

class Notes {
  int? name;
  String? note;
  String? commented;
  String? customActivityLead;
  String? addedOn;
  String? image;

  Notes(
      {this.name,
      this.note,
      this.commented,
      this.customActivityLead,
      this.addedOn,
      this.image});

  Notes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    note = json['note'];
    commented = json['commented'];
    customActivityLead = json['custom_activity_lead'];
    addedOn = json['added_on'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['note'] = note;
    data['commented'] = commented;
    data['custom_activity_lead'] = customActivityLead;
    data['added_on'] = addedOn;
    data['image'] = image;
    return data;
  }
}

class Users {
  String? fullName;
  String? name;

  Users({this.fullName, this.name});

  Users.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['full_name'] = fullName;
    data['name'] = name;
    return data;
  }
}

class WhatsappSms {
  String? message;
  String? name;

  WhatsappSms({this.message, this.name});

  WhatsappSms.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = message;
    data['name'] = name;
    return data;
  }
}
