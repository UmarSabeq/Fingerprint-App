import 'dart:convert';

ReportModel reportModelFromMap(String str) =>
    ReportModel.fromMap(json.decode(str));

String reportModelToMap(ReportModel data) => json.encode(data.toMap());

class ReportModel {
  ReportModel({
    required this.data,
  });

  List<Datum> data;

  factory ReportModel.fromMap(Map<String, dynamic> json) => ReportModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.day,
    required this.workingTimeStart,
    required this.workingTimeEnd,
    required this.shifts,
    required this.timeStart,
    required this.timeEnd,
    required this.delayTime,
    required this.overTime,
    required this.goEarly,
    required this.actualTime,
  });

  int? id;
  DateTime? day;
  String? workingTimeStart;
  String? workingTimeEnd;
  List<Shift>? shifts;
  String? timeStart;
  String? timeEnd;
  String? delayTime;
  dynamic overTime;
  String? goEarly;
  String? actualTime;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        day: DateTime.parse(json["day"]),
        workingTimeStart: json["working_time_start"],
        workingTimeEnd: json["working_time_end"],
        shifts: List<Shift>.from(json["shifts"].map((x) => Shift.fromMap(x))),
        timeStart: json["time_start"],
        timeEnd: json["time_end"],
        delayTime: json["delay_time"],
        overTime: json["over_time"],
        goEarly: json["go_early"],
        actualTime: json["actual_time"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "day":
            "${day!.year.toString().padLeft(4, '0')}-${day!.month.toString().padLeft(2, '0')}-${day!.day.toString().padLeft(2, '0')}",
        "working_time_start": workingTimeStart,
        "working_time_end": workingTimeEnd,
        "shifts": List<dynamic>.from(shifts!.map((x) => x.toMap())),
        "time_start": timeStart,
        "time_end": timeEnd,
        "delay_time": delayTime,
        "over_time": overTime,
        "go_early": goEarly,
        "actual_time": actualTime,
      };
}

class Shift {
  Shift({
    required this.title,
    required this.timeStart,
    required this.timeEnd,
  });

  String? title;
  String? timeStart;
  String? timeEnd;

  factory Shift.fromMap(Map<String, dynamic> json) => Shift(
        title: json["title"],
        timeStart: json["time_start"],
        timeEnd: json["time_end"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "time_start": timeStart,
        "time_end": timeEnd,
      };
}
