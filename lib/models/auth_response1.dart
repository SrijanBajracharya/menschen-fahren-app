/// The response to an authentication request send to Keycloak.
///
/// Contains the authentication token as well as details about it like expire time and refresh token.
class AuthenticationResponse1{

  /// The access token of the Authentication response from the keycloak.
  String accessToken;

  /// The Type of the Token e.g. bearer.
  String tokenType;

  /// The time in milliseconds in which the access token expires.
  int expiresIn;

  /// The time in milliseconds in which the refresh token expires.
  int refreshExpiresIn;

  /// The refresh token received from the keycloak.
  String refreshToken;

  /// The state of the session.
  String sessionState;

  /// The scope of the token.
  String scope;

  AuthenticationResponse1({required this.accessToken, required this.tokenType, required this.expiresIn, required this.refreshExpiresIn, required this.refreshToken, required this.sessionState,required this.scope});

  @override
  String toString() {
    return 'AuthenticationResponse[accessToken=$accessToken, tokenType=$tokenType, expiresIn=$expiresIn, refreshExpiresIn=$refreshExpiresIn, refreshToken=$refreshToken, sessionState=$sessionState, scope=$scope, ]';
  }

  /// Builds a new AuthenticationResponse from the given Json property map.
  factory AuthenticationResponse1.fromJson(Map<String, dynamic> json) {

    return AuthenticationResponse1(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
      refreshExpiresIn: json['refresh_expires_in'],
      refreshToken: json['refresh_token'],
      sessionState: json['session_state'],
      scope: json['scope'],
    );
  }

  /// Returns the properties of the object as a Json map.
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'refresh_expires_in': refreshExpiresIn,
      'refresh_token': refreshToken,
      'session_state': sessionState,
      'scope': scope,
    };
  }
}