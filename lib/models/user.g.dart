// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      name: json['name'] as String,
      email: json['email'] as String,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      status: $enumDecode(_$StatusEnumMap, json['status']),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'gender': _$GenderEnumMap[instance.gender],
      'status': _$StatusEnumMap[instance.status],
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};

const _$StatusEnumMap = {
  Status.active: 'active',
  Status.inactive: 'inactive',
};
