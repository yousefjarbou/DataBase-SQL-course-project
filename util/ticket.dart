class TICKET {
  int? Tid;
  String Departure_time;
  String Status;
  String Vip;
  String Expiry_date;
  String Price;
  String Bid;


  TICKET({this.Tid, required this.Departure_time, required this.Status,
    required this.Vip,required this.Expiry_date,required this.Price,required this.Bid,});

  factory TICKET.fromMap(Map<String, dynamic> json) =>
      TICKET(
        Tid: json['Tid'],
        Departure_time: json['Departure_time'],
        Status: json['Status'],
        Vip: json['Vip'],
        Expiry_date: json['Expiry_date'],
        Price: json['Price'],
        Bid: json['Bid'],
      );

  Map<String, dynamic> toMap() {
    return {
      'Tid': Tid,
      'Departure_time': Departure_time,
      'Status': Status,
      'Vip': Vip,
      'Expiry_date': Expiry_date,
      'Price': Price,
      'Bid': Bid,
    };
  }
}