class EventEditRequest{

  String? userId;

  String? name;

  String? location;

  String? countryCode;

  String? description;

  String? ageGroup;

  DateTime? startDate;

  DateTime? endDate;

  int? numberOfParticipants;

  bool? isPrivate;

  String? eventTypeId;



  EventEditRequest({ this.userId,  this.name,  this.location,  this.countryCode,  this.description
      , this.ageGroup,  this.startDate,  this.endDate,  this.numberOfParticipants,  this.isPrivate,
       this.eventTypeId});

  /* Build an entity from the given json data. */
  factory EventEditRequest.fromJson(Map<String,dynamic> json) {

    return EventEditRequest(
      userId : json['userId'],
      name: json['name'],
      location:json['location'],
      countryCode: json['countryCode'],
      description: json['description'],
      ageGroup: json['ageGroup'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      numberOfParticipants: json['numberOfParticipants'],
      isPrivate: json['isPrivate'],
      eventTypeId: json['eventTypeId'],
    );
  }

  /* Convenience method to translate a Json list of Approval. */
  static List<EventEditRequest> listFromJson(List<dynamic> json) {
    return json.map((value) => EventEditRequest.fromJson(value)).toList();
  }
}