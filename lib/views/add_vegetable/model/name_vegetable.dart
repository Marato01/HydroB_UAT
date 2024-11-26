class Vegetable {
  String name;
  String minpH;
  String maxpH;
  String minEC;
  String maxEC;

  Vegetable(this.name,this.minpH,this.maxpH,this.minEC,this.maxEC);

  // Convert a Vegetable object into a Map (for JSON serialization)
  Map<String, dynamic> toJson() => {
    'name': name,
    'minpH': minpH,
    'maxpH': maxpH,
    'minEC': minEC,
    'maxEC': maxEC,
  };

  // Convert a Map (JSON) into a Vegetable object
  factory Vegetable.fromJson(Map<String, dynamic> json) {
    return Vegetable(
      json['name'],
      json['minpH'],
      json['maxpH'],
      json['minEC'],
      json['maxEC'],
    );
  }
}