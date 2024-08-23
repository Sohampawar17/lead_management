class AddPageSheetModel {
  String? name;
  String? owner;
  int? docstatus;
  int? idx;
  String? pageName;
  String? company;
  int? allowPage;
  String? doctype;
  List<SheetLink>? sheetLink;

  AddPageSheetModel(
      {this.name,
      this.owner,
      this.docstatus,
      this.idx,
      this.pageName,
      this.company,
      this.allowPage,
      this.doctype,
      this.sheetLink});

  AddPageSheetModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    pageName = json['page_name'];
    company = json['company'];
    allowPage = json['allow_page'];
    doctype = json['doctype'];
    if (json['sheet_link'] != null) {
      sheetLink = <SheetLink>[];
      json['sheet_link'].forEach((v) {
        sheetLink!.add(SheetLink.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['page_name'] = pageName;
    data['company'] = company;
    data['allow_page'] = allowPage;
    data['doctype'] = doctype;
    if (sheetLink != null) {
      data['sheet_link'] = sheetLink!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SheetLink {
  String? name;
  String? owner;
  int? docstatus;
  int? idx;
  String? user;
  String? sheetLink;
  int? allow;
  String? parent;
  String? parentfield;
  String? parenttype;

  SheetLink(
      {this.name,
      this.owner,
      this.docstatus,
      this.idx,
      this.user,
      this.sheetLink,
      this.allow,
      this.parent,
      this.parentfield,
      this.parenttype});

  SheetLink.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    user = json['user'];
    sheetLink = json['sheet_link'];
    allow = json['allow'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['user'] = user;
    data['sheet_link'] = sheetLink;
    data['allow'] = allow;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    return data;
  }
}
