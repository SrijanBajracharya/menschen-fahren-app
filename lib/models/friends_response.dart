class FriendResponse{

  String id;

  String firstName;

  String lastName;

  String email;

  String username;

  FriendResponse({required this.id, required this.firstName, required this.lastName, required this.email, required this.username});

  /* Build an entity from the given json data. */
  factory FriendResponse.fromJson(Map<String,dynamic> json) {

    return FriendResponse(
      id : json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      username: json['username']

    );
  }

  /* Convenience method to translate a Json list of Approval. */
  static List<FriendResponse> listFromJson(List<dynamic> json) {
    return json.map((value) => FriendResponse.fromJson(value)).toList();
  }

}