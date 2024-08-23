class ListPageSheetModel {
  String? name;
  String? pageName;
  String? company;

  ListPageSheetModel({this.name, this.pageName, this.company});

  ListPageSheetModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    pageName = json['page_name'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['page_name'] = pageName;
    data['company'] = company;
    return data;
  }
}
