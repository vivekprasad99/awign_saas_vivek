enum Status {
  success('success'),
  failed('failed');

  const Status(this.value);
  final String value;

  static Status get(String strStatus) {
    return switch (strStatus) {
      'success' => success,
      'failed' => failed,
      _ => failed
    };
  }
}

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse.fromJson(Map<String, dynamic> json) {
    status = Status.get(json['status']);
    message = json['message'];
    data = json['data'];
  }

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

