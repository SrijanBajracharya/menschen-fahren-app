import 'package:project_menschen_fahren/models/event_create_request.dart';
import 'package:project_menschen_fahren/models/event_type_response.dart';

class EventResponse {

  String id;

  bool? voided;

  DateTime createdTimestamp;

  EventTypeDtoResponse eventType;

  String userId;

  String name;

  String location;

  String countryCode;

  String description;

  String ageGroup;

  DateTime startDate;

  DateTime endDate;

  int numberOfParticipants;

  bool private;

  String eventTypeId;

  EventResponse({required this.id, required this.voided, required this.createdTimestamp, required this.eventType,required this.userId,required  this.name, required this.location,required  this.countryCode, required this.description
    , required this.ageGroup,required  this.startDate, required this.endDate, required this.numberOfParticipants, required this.private,
    required this.eventTypeId});

  /* Build an entity from the given json data. */
  factory EventResponse.fromJson(Map<String,dynamic> json) {

    return EventResponse(
      id : json['id'],
      voided: json['voided'],
      eventType:EventTypeDtoResponse.fromJson(json['eventType']),
      createdTimestamp: DateTime.parse(json['createdTimestamp']),
      userId : json['userId'],
      name: json['name'],
      location:json['location'],
      countryCode: json['countryCode'],
      description: json['description'],
      ageGroup: json['ageGroup'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      numberOfParticipants: json['numberOfParticipants'],
      private: json['private'],
      eventTypeId: json['eventTypeId'],
    );
  }

  /* Convenience method to translate a Json list of Approval. */
  static List<EventResponse> listFromJson(List<dynamic> json) {
    return json.map((value) => EventResponse.fromJson(value)).toList();
  }

}