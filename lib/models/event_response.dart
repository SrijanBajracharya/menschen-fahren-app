import 'package:project_menschen_fahren/models/event_create_request.dart';
import 'package:project_menschen_fahren/models/event_type_response.dart';

class EventResponse {

  String id;

  bool? voided;

  DateTime createdTimestamp;

  String eventType;

  //String userId;

  String name;

  String location;

  String country;

  String description;

  String ageGroup;

  DateTime startDate;

  DateTime endDate;

  int numberOfParticipants;

  bool private;

  EventResponse({required this.id, required this.voided, required this.createdTimestamp, required this.eventType,required  this.name, required this.location,required  this.country, required this.description
    , required this.ageGroup,required  this.startDate, required this.endDate, required this.numberOfParticipants, required this.private});

  /* Build an entity from the given json data. */
  factory EventResponse.fromJson(Map<String,dynamic> json) {

    return EventResponse(
      id : json['id'],
      voided: json['voided'],
      eventType: json['eventType'],
      createdTimestamp: DateTime.parse(json['createdTimestamp']),
      //userId : json['userId'],
      name: json['name'],
      location:json['location'],
      country: json['country'],
      description: json['description'],
      ageGroup: json['ageGroup'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      numberOfParticipants: json['numberOfParticipants'],
      private: json['private'],
    );
  }

  /* Convenience method to translate a Json list of Approval. */
  static List<EventResponse> listFromJson(List<dynamic> json) {
    return json.map((value) => EventResponse.fromJson(value)).toList();
  }

}