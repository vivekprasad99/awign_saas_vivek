
import 'operator.dart';
import 'query_condition.dart';

class AdvancedSearchRequest {
  static const status = 'status';
  static const startDate = 'start_date';
  static const endDate = 'end_date';
  static const type = 'type';
  static const employeeUuid = 'employee_uuid';
  static const createdAt = 'created_at';
  static const uuid = 'uuid';
  static const managerID = 'manager_id';
  String? _searchColumn;
  String? _searchTerm;
  List<Map<String, QueryCondition>>? _conditions;
  int? _page;
  int? _limit;
  String? _sortOrder;
  String? _sortColumn;
  String? _aggs;
  Map<String, String>? _emailCondition;
  Map<String, String>? _smsCondition;
  Map<String, String>? _notification;
  bool? _skipSaasOrgId;
  bool? _createApplication;
  bool? _analyze;

  void setSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
  }

  void setConditions(List<Map<String, QueryCondition>> conditions) {
    _conditions = conditions;
  }

  void addToConditions(Map<String, QueryCondition> condition) {
    _conditions?.add(condition);
  }

  void setPage(int page) {
    _page = page;
  }

  void setLimit(int limit) {
    _limit = limit;
  }

  void setAggs(String aggs) {
    _aggs = aggs;
  }

  void setSortColumn(String sortColumn) {
    _sortColumn = sortColumn;
  }

  void setSortOrder(String sortOrder) {
    _sortOrder = sortOrder;
  }

  void setAnalyze(bool analyze) {
    _analyze = analyze;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    if (_searchColumn != null)
      _data['search_column'] = _searchColumn;
    if (_searchTerm != null)
      _data['search_term'] = _searchTerm;
    List<Map<String, dynamic>> list = [];
    for (int i = 0; i < _conditions!.length; i++) {
      Map<String, QueryCondition> map = _conditions![i];
      Map<String, dynamic> tempMap = <String, dynamic>{};
      for (MapEntry<String, QueryCondition> e in map.entries) {
        tempMap[e.key] = e.value.toJson();
      }
      list.add(tempMap);
    }
    if(list.isEmpty) {
      // list.add({});
    }
    _data['conditions'] = list.map((e) => e).toList();
    if (_page != null)
    _data['page'] = _page;
    if (_limit != null)
    _data['limit'] = _limit;
    if (_sortOrder != null)
    _data['sort_order'] = _sortOrder;
    if (_sortColumn != null)
    _data['sort_column'] = _sortColumn;
    if (_aggs != null)
    _data['aggs'] = _aggs;
    if (_emailCondition != null)
    _data['email'] = _emailCondition;
    if (_smsCondition != null)
    _data['sms'] = _smsCondition;
    if (_notification != null)
    _data['notification'] = _notification;
    if (_skipSaasOrgId != null)
    _data['skip_saas_org_id'] = _skipSaasOrgId;
    if (_createApplication != null)
      _data['create_application'] = _createApplication;
    if (_analyze != null)
      _data['analyze'] = _analyze;
    return _data;
  }
}

class AdvanceSearchRequestBuilder {
  static const defaultPosition = 0;
  static const defaultLimit = 10;
  late AdvancedSearchRequest request;

  AdvanceSearchRequestBuilder() {
    request = AdvancedSearchRequest();
    request._conditions = [];
    // request._conditions?.add(<String, QueryCondition>{});
  }

  AdvanceSearchRequestBuilder putPropertyToCondition(
      String key, Operator operator, Object value) {
    if (request._conditions != null && request._conditions!.isNotEmpty) {
      for (int i = 0; i < request._conditions!.length; i++) {
        _putPropertyToCondition(i, key, operator, value);
      }
      return this;
    } else {
      return _putPropertyToCondition(defaultPosition, key, operator, value);
    }
  }

  AdvanceSearchRequestBuilder _putPropertyToCondition(
      int position, String key, Operator operator, Object value) {
    if (request._conditions != null &&
        position >= request._conditions!.length) {
      position = request._conditions!.length;
      request._conditions!.add(<String, QueryCondition>{});
    }
    Map<String, QueryCondition> condition = request._conditions![position];
    QueryCondition queryCondition = QueryCondition();
    queryCondition.value = value;
    queryCondition.operator = operator.name();
    condition[key] = queryCondition;
    return this;
  }

  AdvanceSearchRequestBuilder addCondition(
      Map<String, QueryCondition> condition) {
    return _addCondition(defaultPosition, condition);
  }

  AdvanceSearchRequestBuilder _addCondition(
      int position, Map<String, QueryCondition>? condition) {
    if (condition == null) {
      return this;
    }
    if (position >= request._conditions!.length) {
      request._conditions!.add(condition);
    } else {
      request._conditions![position] = condition;
    }
    return this;
  }

  AdvanceSearchRequestBuilder setConditions(
      List<Map<String, QueryCondition>>? conditions) {
    conditions ??= <Map<String, QueryCondition>>[];
    request._conditions = conditions;
    return this;
  }

  AdvanceSearchRequestBuilder setPage(int page) {
    request._page = page;
    return this;
  }

  AdvanceSearchRequestBuilder setLimit(int? limit) {
    if (limit != null && limit > 0) {
      request._limit = limit;
    }
    return this;
  }

  AdvanceSearchRequestBuilder setAnalyze(bool value) {
    request._analyze = value;
    return this;
  }

  AdvanceSearchRequestBuilder setSearchColumn(String searchColumn) {
    request._searchColumn = searchColumn;
    return this;
  }

  AdvanceSearchRequestBuilder setSearchTerm(String searchTerm) {
    request._searchTerm = searchTerm;
    return this;
  }

  AdvanceSearchRequestBuilder setSortOrder(String sortOrder) {
    request._sortOrder = sortOrder;
    return this;
  }

  AdvanceSearchRequestBuilder setSortColumn(String sortColumn) {
    request._sortColumn = sortColumn;
    return this;
  }

  AdvanceSearchRequestBuilder setEmailCondition(
      Map<String, String> emailCondition) {
    request._emailCondition = emailCondition;
    return this;
  }

  AdvanceSearchRequestBuilder setSMSCondition(
      Map<String, String> smsCondition) {
    request._smsCondition = smsCondition;
    return this;
  }

  AdvanceSearchRequestBuilder setNotification(
      Map<String, String> notification) {
    request._notification = notification;
    return this;
  }

  AdvanceSearchRequestBuilder setSkipSaasOrgId(bool skipSaasOrgId) {
    request._skipSaasOrgId = skipSaasOrgId;
    return this;
  }

  AdvanceSearchRequestBuilder setCreateApplication(bool createApplication) {
    request._createApplication = createApplication;
    return this;
  }

  AdvancedSearchRequest build() {
    return request;
  }
}
