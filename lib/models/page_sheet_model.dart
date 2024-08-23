class PageMasters {
  List<PageList>? pageList;
  String? supportMobile;
  String? supportSms;

  PageMasters({this.pageList, this.supportMobile, this.supportSms});

  PageMasters.fromJson(Map<String, dynamic> json) {
    if (json['page_list'] != null) {
      pageList = <PageList>[];
      json['page_list'].forEach((v) {
        pageList!.add(PageList.fromJson(v));
      });
    }
    supportMobile = json['support_mobile'];
    supportSms = json['support_sms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pageList != null) {
      data['page_list'] = pageList!.map((v) => v.toJson()).toList();
    }
    data['support_mobile'] = supportMobile;
    data['support_sms'] = supportSms;
    return data;
  }
}

class PageList {
  String? pageName;
  String? name;
  String? company;

  PageList({this.pageName, this.name, this.company});

  PageList.fromJson(Map<String, dynamic> json) {
    pageName = json['page_name'];
    name = json['name'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['page_name'] = pageName;
    data['name'] = name;
    data['company'] = company;
    return data;
  }
}
