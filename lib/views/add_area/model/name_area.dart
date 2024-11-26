class NameArea {
  String names;

  NameArea(this.names);

  // Convert a NameArea into a Map. The keys must correspond to the names of the
  // fields in the JSON.
  Map<String, dynamic> toJson() {
    return {
      'names': names,
    };
  }

  // Extract a NameArea object from a Map.
  NameArea.fromJson(Map<String, dynamic> json) : names = json['names'];
}
