class AddLeadModel {
  String? name;
  String? firstName;
  String? leadName;
  String? customSfollowUp;
  String? customFollowUpDatetime;
  String? source;
  String? leadOwner;
  int? customSeenLead;
  String? emailId;
  String? mobileNo;
  String? whatsappNo;
  String? territory;
  String? campaignName;
  String? customLeadsDataCreatedTime;
  String? leadsData;

  AddLeadModel(
      {this.name,
      this.firstName,
      this.leadName,
      this.customSfollowUp,
      this.customFollowUpDatetime,
      this.source,
      this.leadOwner,
      this.customSeenLead,
      this.emailId,
      this.mobileNo,
      this.whatsappNo,
      this.territory,
      this.campaignName,
      this.customLeadsDataCreatedTime,
      this.leadsData});

  AddLeadModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    firstName = json['first_name'];
    leadName = json['lead_name'];
    customSfollowUp = json['custom_sfollow_up'];
    customFollowUpDatetime = json['custom_follow_up_datetime'];
    source = json['source'];
    leadOwner = json['lead_owner'];
    customSeenLead = json['custom_seen_lead'];
    emailId = json['email_id'];
    mobileNo = json['mobile_no'];
    whatsappNo = json['whatsapp_no'];
    territory = json['territory'];
    campaignName = json['campaign_name'];
    customLeadsDataCreatedTime = json['custom_leads_data_created_time'];
    leadsData = json['leads_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['first_name'] = firstName;
    data['lead_name'] = leadName;
    data['custom_sfollow_up'] = customSfollowUp;
    data['custom_follow_up_datetime'] = customFollowUpDatetime;
    data['source'] = source;
    data['lead_owner'] = leadOwner;
    data['custom_seen_lead'] = customSeenLead;
    data['email_id'] = emailId;
    data['mobile_no'] = mobileNo;
    data['whatsapp_no'] = whatsappNo;
    data['territory'] = territory;
    data['campaign_name'] = campaignName;
    data['custom_leads_data_created_time'] = customLeadsDataCreatedTime;
    data['leads_data'] = leadsData;
    return data;
  }

  void then(Null Function(dynamic _) param0) {}
}
