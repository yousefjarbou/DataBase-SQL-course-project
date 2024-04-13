class BUS {
  int? Bid;
  String BusNumber;

  BUS({this.Bid, required this.BusNumber,});

  factory BUS.fromMap(Map<String, dynamic> json) =>
      BUS(
        Bid: json['Bid'],
        BusNumber: json['BusNumber'],
      );

  Map<String, dynamic> toMap() {
    return {
      'Bid': Bid,
      'BusNumber': BusNumber,
    };
  }
}