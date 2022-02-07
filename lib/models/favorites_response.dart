import 'package:project_menschen_fahren/models/event_response.dart';

class MyFavoriteResponse {
  String id;

  EventResponse event;

  MyFavoriteResponse({required this.id, required this.event});

  /* Build an entity from the given json data. */
  factory MyFavoriteResponse.fromJson(Map<String,dynamic> json) {

    return MyFavoriteResponse(
      id : json['id'],
      event:EventResponse.fromJson(json['event']),

    );
  }

  /* Convenience method to translate a Json list of Approval. */
  static List<MyFavoriteResponse> listFromJson(List<dynamic> json) {
    return json.map((value) => MyFavoriteResponse.fromJson(value)).toList();
  }
}
