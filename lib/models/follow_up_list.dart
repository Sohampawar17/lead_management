class FollowUpListLeadModel {
  List<Overdue>? overdue;
  List<Overdue>? today;
  List<Overdue>? upcoming;
  List<Overdue>? someDay;

  FollowUpListLeadModel({this.overdue, this.today, this.upcoming,this.someDay});

  FollowUpListLeadModel.fromJson(Map<String, dynamic> json) {
    if (json['overdue'] != null) {
      overdue = <Overdue>[];
      json['overdue'].forEach((v) {
        overdue!.add(Overdue.fromJson(v));
      });
    }
    if (json['today'] != null) {
      today = <Overdue>[];
      json['today'].forEach((v) {
        today!.add(Overdue.fromJson(v));
      });
    }
    if (json['upcoming'] != null) {
      upcoming = <Overdue>[];
      json['upcoming'].forEach((v) {
        upcoming!.add(Overdue.fromJson(v));
      });
    }
    if (json['some_day'] != null) {
      someDay = <Overdue>[];
      json['some_day'].forEach((v) {
        someDay!.add(Overdue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (overdue != null) {
      data['overdue'] = overdue!.map((v) => v.toJson()).toList();
    }
    if (today != null) {
      data['today'] = today!.map((v) => v.toJson()).toList();
    }
    if (upcoming != null) {
      data['upcoming'] = upcoming!.map((v) => v.toJson()).toList();
    }
     if (someDay != null) {
      data['some_day'] = someDay!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Overdue {
  String? name;
  String? owner;
  String? leadName;
  String? source;
  String? customPageName;
  String? campaignName;
  String? assignedTo;
  String? abbreviation;
  int? customSeenLead;

  Overdue(
      {this.name,
      this.owner,
      this.leadName,
      this.source,
      this.customPageName,
      this.campaignName,
      this.assignedTo,
      this.abbreviation,
      this.customSeenLead});

  Overdue.fromJson(Map<String, dynamic> json) {
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
