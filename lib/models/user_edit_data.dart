class UserEditRequest {
  String firstName;

  String lastName;

  String email;

  String username;

  UserEditRequest(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.username});

  /* Build an entity from the given json data. */
  factory UserEditRequest.fromJson(Map<String,dynamic> json) {

    return UserEditRequest(
      firstName: json['firstName'],
      lastName:json['lastName'],
      email: json['email'],
      username: json['username'],
    );
  }

  /* Convenience method to translate a Json list of Approval. */
  static List<UserEditRequest> listFromJson(List<dynamic> json) {
    return json.map((value) => UserEditRequest.fromJson(value)).toList();
  }
}
