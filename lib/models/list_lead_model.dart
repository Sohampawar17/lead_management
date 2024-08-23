class ListLeadModel {
  String? name;
  String? owner;
  String? leadName;
  String? source;
  String? customPageName;
  String? campaignName;
  String? assignedTo;
  String? abbreviation;
  int? customSeenLead;

  ListLeadModel(
      {this.name,
      this.owner,
      this.leadName,
      this.source,
      this.customPageName,
      this.campaignName,
      this.assignedTo,
      this.abbreviation,
      this.customSeenLead});

  ListLeadModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    leadName = json['lead_name'];
    source = json['source'];
    customPageName = json['custom_page_name'];
    campaignName = json['campaign_name'];
    assignedTo = json['assigned_to'];
    abbreviation = json['abbreviation'];
    customSeenLead = json['custom_seen_lead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['lead_name'] = leadName;
    data['source'] = source;
    data['custom_page_name'] = customPageName;
    data['campaign_name'] = campaignName;
    data['assigned_to'] = assignedTo;
    data['abbreviation'] = abbreviation;
    data['custom_seen_lead'] = customSeenLead;
    return data;
  }
}
