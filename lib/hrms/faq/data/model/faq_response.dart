class FaqResponse {
  List<Faqs>? faqs;

  FaqResponse({this.faqs});

  FaqResponse.fromJson(Map<String, dynamic> json) {
    if (json['faqs'] != null) {
      faqs = <Faqs>[];
      json['faqs'].forEach((v) {
        faqs!.add(Faqs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (faqs != null) {
      data['faqs'] = faqs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Faqs {
  String? type;
  String? title;
  String? description;

  Faqs({this.type, this.title, this.description});

  Faqs.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
