class FaqsTypeResponse {
  List<String>? types;
  FaqsTypeResponse({this.types});

  FaqsTypeResponse.fromJson(Map<String, dynamic> json) {
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['types'] = types;
    return data;
  }
}

class NavBarData
{
  String? navBarItem;
  bool isSelected;
  NavBarData({required this.navBarItem,this.isSelected = false});
}

