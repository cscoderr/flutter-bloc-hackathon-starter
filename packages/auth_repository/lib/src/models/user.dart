import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String? id;
  final String? email;
  final List<String>? roles;
  final String? firstName;
  final String? lastName;

  const User({
    this.id,
    this.email,
    this.roles,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
