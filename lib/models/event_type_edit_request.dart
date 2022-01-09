class EventTypeEditRequest{

  String name;

  String description;

  bool voided;

  EventTypeEditRequest({required this.name,required this.description,required this.voided});

  factory EventTypeEditRequest.fromJson(Map<String,dynamic> json) {

    return EventTypeEditRequest(
      name : json['name'],
      voided: json['voided'],
      description:json['description'],
    );
  }

  /* Convenience method to translate a Json list of Approval. */
  static List<EventTypeEditRequest> listFromJson(List<dynamic> json) {
    return json.map((value) => EventTypeEditRequest.fromJson(value)).toList();
  }
}