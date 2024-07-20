import 'dart:convert';

Users usersFromMap(String str) => Users.fromMap(json.decode(str));

String usersToMap(Users data) => json.encode(data.toMap());


class Users {
  final int? usrId;
  final String? usrName;
  final String usrEmail;
  final String? usrMobile;
  final String usrPassword;
  final String? createdAt;

  Users({
    this.usrId,
    this.usrName,
    required this.usrEmail,
    this.usrMobile,
    required this.usrPassword,
    this.createdAt,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
    usrId: json["usrId"],
    usrName: json["usrName"],
    usrEmail: json["usrEmail"],
    usrMobile: json["usrMobile"],
    usrPassword: json["usrPassword"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toMap() => {
    "usrId": usrId,
    "usrName": usrName,
    "usrEmail": usrEmail,
    "usrMobile": usrMobile,
    "usrPassword": usrPassword,
    "createdAt": createdAt,
  };
}
