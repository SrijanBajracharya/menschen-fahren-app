import 'package:project_menschen_fahren/models/event_response.dart';
import 'package:project_menschen_fahren/models/user_response.dart';

class NotificationResponse {
  String id;

  UserResponse senderUser;

  UserResponse receiverUser;

  EventResponse event;

  String notificationType;

  String notificationStatus;

  DateTime modifiedTimestamp;

  bool alsoVoided;

  bool matchedReceiverUserId;

  bool matchedSenderUserId;

  NotificationResponse({
    required this.id,
    required this.senderUser,
    required this.receiverUser,
    required this.event,
    required this.notificationType,
    required this.notificationStatus,
    required this.modifiedTimestamp,
    required this.alsoVoided,
    required this.matchedReceiverUserId,
    required this.matchedSenderUserId
  }): super();

  /* Build an entity from the given json data. */
  factory NotificationResponse.fromJson(Map<String,dynamic> json) {

    return NotificationResponse(
      id : json['id'],
      senderUser: UserResponse.fromJson(json['senderUser']),
      receiverUser: UserResponse.fromJson(json['receiverUser']),
      modifiedTimestamp: DateTime.parse(json['modifiedTimestamp']),
      event: EventResponse.fromJson(json['event']),
      notificationStatus:json['notificationStatus'],
      notificationType: json['notificationType'],
      alsoVoided: json['alsoVoided'] as bool,
      matchedReceiverUserId: json['matchedReceiverUserId'] as bool,
      matchedSenderUserId: json['matchedSenderUserId'] as bool,
    );
  }

  /* Convenience method to translate a Json list of Approval. */
  static List<NotificationResponse> listFromJson(List<dynamic> json) {
    return json.map((value) => NotificationResponse.fromJson(value)).toList();
  }
}
