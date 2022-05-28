// {"id":3,"name":"Aanjaneya Menon","email":"menon_aanjaneya@rath.biz","gender":"male","status":"active"}
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

enum Gender { male, female }

enum Status { active, inactive }

@JsonSerializable()
class User extends Equatable {
  const User({
    this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  final int? id;

  final String name;

  final String email;

  final Gender gender;

  final Status status;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id, name, email, gender, status];
}
