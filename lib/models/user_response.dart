class UserResponse {
  String id;

  bool voided;

  DateTime modifiedTimestamp;

  DateTime createdTimestamp;

  String password;

  String firstName;

  String lastName;

  String email;

  String username;

  UserResponse({
    required this.id,
    required this.voided,
    required this.modifiedTimestamp,
    required this.createdTimestamp,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
  });


  /* Build an entity from the given json data. */
  factory UserResponse.fromJson(Map<String,dynamic> json) {

    return UserResponse(
      id : json['id'],
      voided: json['voided'],
      createdTimestamp: DateTime.parse(json['createdTimestamp']),
      modifiedTimestamp: DateTime.parse(json['modifiedTimestamp']),
      password : json['password'],
      firstName: json['firstName'],
      lastName:json['lastName'],
      email: json['email'],
      username: json['username'],
    );
  }

  /* Convenience method to translate a Json list of Approval. */
  static List<UserResponse> listFromJson(List<dynamic> json) {
    return json.map((value) => UserResponse.fromJson(value)).toList();
  }
}
