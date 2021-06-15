class ApiRegister {
  String? message;
  Null result;

  ApiRegister({this.message, this.result});

  ApiRegister.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['result'] = this.result;
    return data;
  }
}
