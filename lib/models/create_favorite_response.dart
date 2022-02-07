class CreateFavoriteResponse{
  String id;

  String eventId;

  CreateFavoriteResponse({required this.id, required this.eventId});

  /* Build an entity from the given json data. */
  factory CreateFavoriteResponse.fromJson(Map<String,dynamic> json) {

    return CreateFavoriteResponse(
      id : json['id'],
      eventId: json['eventId'],

    );
  }

  /* Convenience method to translate a Json list of Approval. */
  static List<CreateFavoriteResponse> listFromJson(List<dynamic> json) {
    return json.map((value) => CreateFavoriteResponse.fromJson(value)).toList();
  }
}