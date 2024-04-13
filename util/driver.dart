class DRIVER {
  int? id;
  String License_no;
  String FNAME;
  String LNAME;
  String Bid;
  DRIVER({this.id, required this.License_no, required this.FNAME,required this.LNAME,required this.Bid,});

  factory DRIVER.fromMap(Map<String, dynamic> json) =>
      DRIVER(
        id: json['id'],
        License_no: json['License_no'],
        FNAME: json['FNAME'],
        LNAME: json['LNAME'],
        Bid: json['Bid'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'License_no': License_no,
      'FNAME': FNAME,
      'LNAME': LNAME,
      'Bid': Bid,
    };
  }
}
