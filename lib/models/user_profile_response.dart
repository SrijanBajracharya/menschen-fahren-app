import 'package:project_menschen_fahren/models/user_edit_data.dart';
import 'package:project_menschen_fahren/models/user_response.dart';

class UserProfileResponse {
  String? roleId;

  String? dateOfBirth;

  bool? termsAndAgreement;

  String? timezone;

  String? photo;

  String? address;

  String? gender;

  String? phoneNumber;

  String? description;

  String? education;

  String? hobbies;

  String? experiences;

  String? userId;

  String id;

  String country;

  UserEditRequest user;

  bool voided;

  UserProfileResponse(
      {required this.id,
      required this.user,
      required this.voided,
      this.roleId,
      this.dateOfBirth,
      this.termsAndAgreement,
      this.timezone,
      this.photo,
      this.address,
      this.gender,
      this.phoneNumber,
      this.description,
      this.education,
      this.hobbies,
      this.experiences,
      this.userId,
      required this.country,});


  /* Build an entity from the given json data. */
  factory UserProfileResponse.fromJson(Map<String,dynamic> json) {

    return UserProfileResponse(
      id : json['id'],
      voided: json['voided'],
      user: UserEditRequest.fromJson(json['user']),
      roleId: json['roleId'],
      dateOfBirth : json['dateOfBirth'],
      termsAndAgreement: json['termsAndAgreement'],
      timezone:json['timezone'],
      photo: json['photo'],
      address: json['address'],
      gender: json['gender'],
      phoneNumber : json['phoneNumber'],
      description: json['description'],
      education:json['education'],
      hobbies: json['hobbies'],
      experiences: json['experiences'],
      userId: json['userId'],
      country: json['country']
    );
  }

  /* Convenience method to translate a Json list of Approval. */
  static List<UserProfileResponse> listFromJson(List<dynamic> json) {
    return json.map((value) => UserProfileResponse.fromJson(value)).toList();
  }
}
