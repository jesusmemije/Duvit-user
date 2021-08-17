import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  
    LoginModel({
        this.code        = "",
        this.message     = "",
        this.name        = "",
        this.email       = "",
        this.idUser      = 0,
        this.idStaff     = 0,
        this.idCompany   = 0,
        this.idGender    = 0,
        this.lat         = 0.0,
        this.long        = 0.0,
        this.token       = "",
        this.validateGps = "",
        this.active      = "",
    });

    String code;
    String message;
    String name;
    String email;
    int idUser;
    int idStaff;
    int idCompany;
    int idGender;
    double lat;
    double long;
    String token;
    String validateGps;
    String active;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        code        : json["code"],
        message     : json["message"],
        name        : json["name"],
        email       : json["email"],
        idUser      : json["idUser"],
        idStaff     : json["idStaff"],
        idCompany   : json["idCompany"],
        idGender    : json["idGender"],
        lat         : json["lat"].toDouble(),
        long        : json["long"].toDouble(),
        token       : json["token"],
        validateGps : json["validateGPS"],
        active      : json["active"],
    );

    Map<String, dynamic> toJson() => {
        "code"        : code,
        "message"     : message,
        "name"        : name,
        "email"       : email,
        "idUser"      : idUser,
        "idStaff"     : idStaff,
        "idCompany"   : idCompany,
        "idGender"    : idGender,
        "lat"         : lat,
        "long"        : long,
        "token"       : token,
        "validateGPS" : validateGps,
        "active"      : active,
    };
}
