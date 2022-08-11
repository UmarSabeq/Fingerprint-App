import 'dart:convert';

ReportSummaryModel reportSummaryModelFromMap(String str) =>
    ReportSummaryModel.fromMap(json.decode(str));

String reportSummaryModelToMap(ReportSummaryModel data) =>
    json.encode(data.toMap());

class ReportSummaryModel {
  ReportSummaryModel({
    required this.data,
  });

  Data data;

  factory ReportSummaryModel.fromMap(Map<String, dynamic> json) =>
      ReportSummaryModel(
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class Data {
  Data({
    required this.employeeId,
    required this.actTime,
    required this.avlTime,
    required this.goEarly,
    required this.overTime,
    required this.month,
    required this.year,
  });

  int employeeId;
  String actTime;
  String avlTime;
  String goEarly;
  String overTime;
  String month;
  dynamic year;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        employeeId: json["employee_id"],
        actTime: json["act_time"],
        avlTime: json["avl_time"],
        goEarly: json["go_early"],
        overTime: json["over_time"],
        month: json["month"],
        year: json["year"],
      );

  Map<String, dynamic> toMap() => {
        "employee_id": employeeId,
        "act_time": actTime,
        "avl_time": avlTime,
        "go_early": goEarly,
        "over_time": overTime,
        "month": month,
        "year": year,
      };
}
