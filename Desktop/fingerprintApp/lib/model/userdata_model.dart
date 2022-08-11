import 'dart:convert';

UserDataModel userDataModelFromMap(String str) =>
    UserDataModel.fromMap(json.decode(str));

String userDataModelToMap(UserDataModel data) => json.encode(data.toMap());

class UserDataModel {
  UserDataModel({
    required this.data,
  });

  Data data;

  factory UserDataModel.fromMap(Map<String, dynamic> json) => UserDataModel(
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class Data {
  Data({
    required this.id,
    required this.fullName,
    required this.phoneNum,
    required this.mid,
    required this.profession,
  });

  int id;
  String fullName;
  String phoneNum;
  String mid;
  String profession;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        fullName: json["full_name"],
        phoneNum: json["phone_num"],
        mid: json["mid"],
        profession: json["profession"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "full_name": fullName,
        "phone_num": phoneNum,
        "mid": mid,
        "profession": profession,
      };
}
