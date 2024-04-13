class USERS {
  int? PID;
  String MOBILE_NO;
  String FNAME;
  String LNAME;
  String PASSWORD;

  USERS({this.PID, required this.MOBILE_NO, required this.FNAME,required this.LNAME,required this.PASSWORD,});

  factory USERS.fromMap(Map<String, dynamic> json) =>
      USERS(
        PID: json['PID'],
        MOBILE_NO: json['MOBILE_NO'],
        FNAME: json['FNAME'],
        LNAME: json['LNAME'],
        PASSWORD: json['PASSWORD'],
      );

  Map<String, dynamic> toMap() {
    return {
      'PID': PID,
      'MOBILE_NO': MOBILE_NO,
      'FNAME': FNAME,
      'LNAME': LNAME,
      'PASSWORD': PASSWORD,
    };
  }
}