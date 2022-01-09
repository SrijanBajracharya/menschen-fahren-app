/// The response to an authentication request send to Keycloak.
///
/// Contains the authentication token as well as details about it like expire time and refresh token.
class AuthenticationResponse{

  /// The access token of the Authentication response from the keycloak.
  String accessToken;

  AuthenticationResponse({required this.accessToken});

  @override
  String toString() {
    return 'AuthenticationResponse[accessToken=$accessToken ]';
  }

  /// Builds a new AuthenticationResponse from the given Json property map.
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) {

    return AuthenticationResponse(
      accessToken: json['jwttoken'],
    );
  }

  /// Returns the properties of the object as a Json map.
  Map<String, dynamic> toJson() {
    return {
      'jwttoken': accessToken,
    };
  }
}