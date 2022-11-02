import 'package:json_annotation/json_annotation.dart';
import 'package:pantry_chef_app/user/models/user.dart';

part 'authenticate_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthenticateResponse {
  AuthenticateResponse();

  @JsonKey(name: 'access_token')
  String? accessToken;

  late User? user;

  @JsonKey(name: 'new_user')
  bool? newUser;

  factory AuthenticateResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticateResponseToJson(this);
}
