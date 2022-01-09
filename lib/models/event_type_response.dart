class EventTypeDtoResponse {
  DateTime createdTimestamp;

  DateTime modifiedTimestamp;

  String id;

  String name;

  String description;

  bool voided;

  EventTypeDtoResponse(
      {required this.id,
      required this.createdTimestamp,
      required this.modifiedTimestamp,
      required this.name,
      required this.description,
      required this.voided})
      : super();

  factory EventTypeDtoResponse.fromJson(Map<String, dynamic> json) {
    return EventTypeDtoResponse(
        createdTimestamp: DateTime.parse(json['createdTimestamp']),
        modifiedTimestamp: DateTime.parse(json['modifiedTimestamp']),
        id: json['id'],
        voided: json['voided'],
        name: json['name'],
        description: json['description']);
  }

  /* Convenience method to translate a Json list of Approval. */
  static List<EventTypeDtoResponse> listFromJson(List<dynamic> json) {
    return json.map((value) => EventTypeDtoResponse.fromJson(value)).toList();
  }
}
