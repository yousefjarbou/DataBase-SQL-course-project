class ROUTE {
  int? Rid;
  String Pickup_point;
  String Arrival_point;

  ROUTE({this.Rid, required this.Pickup_point, required this.Arrival_point,});

  factory ROUTE.fromMap(Map<String, dynamic> json) =>
      ROUTE(
        Rid: json['Rid'],
        Pickup_point: json['Pickup_point'],
        Arrival_point: json['Arrival_point'],
      );

  Map<String, dynamic> toMap() {
    return {
      'Rid': Rid,
      'Pickup_point': Pickup_point,
      'Arrival_point': Arrival_point,
    };
  }
}