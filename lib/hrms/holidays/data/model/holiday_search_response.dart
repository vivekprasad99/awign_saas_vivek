import '../../../leaves/data/model/leave.dart';

enum HolidayType {
  holiday('HOLIDAY'),
  restricted('RESTRICTED');

  const HolidayType(this.value);

  final String value;

  static HolidayType? get(strShift) {
    switch(strShift) {
      case 'HOLIDAY':
        return HolidayType.holiday;
      case 'RESTRICTED':
        return HolidayType.restricted;
      default:
        return null;
    }
  }
}

class HolidaySearchResponse {
  List<Holiday>? holidays;

  HolidaySearchResponse({this.holidays});

  HolidaySearchResponse.fromJson(Map<String, dynamic> json) {
    if (json['holidays'] != null) {
      holidays = <Holiday>[];
      json['holidays'].forEach((v) {
        holidays!.add(Holiday.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (holidays != null) {
      data['holidays'] = holidays!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Holiday {
  int? id;
  String? name;
  String? date;
  String? state;
  int? leaveId;
  bool? applied;
  HolidayType? holidayType;
  String? createdAt;
  String? updatedAt;
  Leave? holidayTransaction;

  Holiday(
      {this.id,
        this.name,
        this.date,
        this.state,
        this.leaveId,
        this.applied,
        this.holidayType,
        this.createdAt,
        this.updatedAt,
        this.holidayTransaction});

  Holiday.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    state = json['state'];
    leaveId = json['leave_id'];
    applied = json['applied'];
    holidayType = HolidayType.get(json['holiday_type']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    holidayTransaction = json['holiday_transaction'] != null
        ? Leave.fromJson(json['holiday_transaction'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['date'] = date;
    data['state'] = state;
    data['leave_id'] = leaveId;
    data['applied'] = applied;
    data['holiday_type'] = holidayType?.value;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (holidayTransaction != null) {
      data['holiday_transaction'] = holidayTransaction!.toJson();
    }
    return data;
  }
}