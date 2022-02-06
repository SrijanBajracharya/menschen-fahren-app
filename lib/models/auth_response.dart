/// The response to an authentication request send to Keycloak.
///
/// Contains the authentication token as well as details about it like expire time and refresh token.
class AuthenticationResponse{

  /// The access token of the Authentication response from the keycloak.
  String accessToken;

  String tokenType;

  DateTime expiryDate;

  AuthenticationResponse({required this.accessToken,required this.tokenType, required this.expiryDate});

  @override
  String toString() {
    return 'AuthenticationResponse[accessToken=$accessToken ]';
  }

  /// Builds a new AuthenticationResponse from the given Json property map.
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) {

    return AuthenticationResponse(
      accessToken: json['accessToken'],
      tokenType: json['tokenType'],
      expiryDate: DateTime.parse(json['expiryDate'])
    );
  }

  /// Returns the properties of the object as a Json map.
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'tokenType': tokenType,
      'expiryDate': expiryDate
    };
  }
}